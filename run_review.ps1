# run_review.ps1 — single-iteration repo review automation for aresmaxs.com
# Usage:
#   pwsh ./run_review.ps1 -Mode discover|review|fix|verify|all

param(
  [ValidateSet('discover','review','fix','verify','all')]
  [string]$Mode = 'all'
)

$ErrorActionPreference = 'Continue'
$Root = $PSScriptRoot
Set-Location $Root
$LogDir = Join-Path $Root 'artifacts/logs'
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
$Ts = (Get-Date -Format 'yyyyMMddTHHmmssZ')
$LogFile = Join-Path $LogDir "review-$Ts.log"

function Log($msg) {
  $line = "[$(Get-Date -Format 'HH:mm:ssZ')] $msg"
  Write-Host $line
  Add-Content -Path $LogFile -Value $line
}
function Section($s) { Log ""; Log "== $s ==" }

function Phase-Discover {
  Section 'DISCOVER'
  $branch = (git symbolic-ref --short HEAD 2>$null)
  Log "Default branch: $branch"
  $count = (git ls-files | Measure-Object).Count
  Log "Tracked files: $count"
  Log 'Workflows:'
  Get-ChildItem .github/workflows -ErrorAction SilentlyContinue | ForEach-Object { Log "  $($_.Name)" }
}

function Phase-Review {
  Section 'REVIEW — doc frontmatter'
  $py = @'
import re, os, sys
files = []
for d in ['docs', 'docs/ADR']:
    if os.path.isdir(d):
        for f in sorted(os.listdir(d)):
            if f.endswith('.md'):
                files.append(os.path.join(d, f).replace(os.sep,'/'))
VALID = {'Draft','Active','Review','Deprecated','Archived'}
errors = []
for path in files:
    text = open(path, encoding='utf-8', errors='ignore').read()
    m = re.match(r'^---\n(.*?)\n---', text, re.DOTALL)
    if not m: errors.append(f'{path}: NO_FRONTMATTER'); continue
    fm = m.group(1)
    for r in ['title', 'owner', 'status', 'last_reviewed']:
        if not re.search(rf'^{r}:', fm, re.MULTILINE): errors.append(f'{path}: missing {r}')
    sm = re.search(r'^status:\s*(.+)$', fm, re.MULTILINE)
    if sm and sm.group(1).strip().strip('"') not in VALID:
        errors.append(f'{path}: invalid status')
for e in errors: print('ERR', e)
print('OK' if not errors else f'FAIL: {len(errors)} errors')
sys.exit(1 if errors else 0)
'@
  $py | python3 -
  $fmRc = $LASTEXITCODE

  Section 'REVIEW — UTF-8 mojibake'
  $moji = (Select-String -Path AGENTS.md -Pattern 'â€' -SimpleMatch -ErrorAction SilentlyContinue | Measure-Object).Count
  Log "AGENTS.md mojibake count: $moji"

  Section 'REVIEW — RUNBOOK branch references'
  $bad = (Select-String -Path docs/RUNBOOK.md -Pattern 'origin main| main / root|branch: main' -ErrorAction SilentlyContinue | Measure-Object).Count
  Log "RUNBOOK 'main' refs: $bad"

  return ($fmRc + $moji + $bad)
}

function Phase-Fix {
  Section 'FIX'
  Log 'Fixes for F-0001..F-0004 were applied by /remediate-repo skill execution.'
  Log 'F-0005 (CSP tightening) is needs_owner — requires browser verification.'
}

function Phase-Verify {
  Section 'VERIFY'
  $rc = 0

  $reviewRc = Phase-Review
  if ($reviewRc -ne 0) { $rc = 1 }

  if (Get-Command jq -ErrorAction SilentlyContinue) {
    $openHigh = (jq '[.findings[] | select(.severity==\"critical\" or .severity==\"high\") | select(.status==\"open\" or .status==\"in_progress\")] | length' findings.json 2>$null)
    Log "Open critical/high findings: $openHigh"
    if ([int]$openHigh -gt 0) { $rc = 1 }
  }

  if ($rc -eq 0) { Log 'VERIFY: ALL CHECKS PASSED' } else { Log 'VERIFY: FAILURES PRESENT' }
  exit $rc
}

switch ($Mode) {
  'discover' { Phase-Discover }
  'review'   { Phase-Discover; [void](Phase-Review) }
  'fix'      { Phase-Fix }
  'verify'   { Phase-Verify }
  'all'      { Phase-Discover; [void](Phase-Review); Phase-Fix; Phase-Verify }
}
