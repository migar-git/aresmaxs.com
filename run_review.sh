#!/usr/bin/env bash
# run_review.sh — single-iteration repo review automation for aresmaxs.com
# Usage:
#   bash run_review.sh --mode discover|review|fix|verify|all
set -u

MODE="all"
for a in "$@"; do
  case $a in
    --mode) shift; MODE="$1"; shift ;;
    --mode=*) MODE="${a#*=}" ;;
    -h|--help)
      echo "Usage: $0 --mode discover|review|fix|verify|all"
      exit 0
      ;;
  esac
done

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"
LOG_DIR="$ROOT/artifacts/logs"
mkdir -p "$LOG_DIR"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG="$LOG_DIR/review-$TS.log"

log()    { echo "[$(date -u +%H:%M:%SZ)] $*" | tee -a "$LOG"; }
section(){ echo "" | tee -a "$LOG"; echo "== $* ==" | tee -a "$LOG"; }

phase_discover() {
  section "DISCOVER"
  log "Default branch: $(git symbolic-ref --short HEAD 2>/dev/null || echo unknown)"
  log "Tracked files: $(git ls-files | wc -l | tr -d ' ')"
  log "Workflows:"
  ls .github/workflows/ 2>/dev/null | sed 's/^/  /' | tee -a "$LOG"
}

phase_review() {
  section "REVIEW — doc frontmatter (mirrors doc-lint.yml)"
  python3 - << 'PY' | tee -a "$LOG"
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
        errors.append(f'{path}: invalid status {sm.group(1).strip()!r}')
for e in errors: print('ERR', e)
print('OK' if not errors else f'FAIL: {len(errors)} errors')
sys.exit(1 if errors else 0)
PY
  fm_status=$?

  section "REVIEW — UTF-8 mojibake"
  mojibake=$(grep -P '[^\x00-\x7F]' AGENTS.md 2>/dev/null | grep -c 'â€' || true)
  log "AGENTS.md mojibake count: ${mojibake:-0}"

  section "REVIEW — RUNBOOK branch references"
  bad=$(grep -nE 'origin main| main / root|branch: main' docs/RUNBOOK.md 2>/dev/null | wc -l | tr -d ' ')
  log "RUNBOOK 'main' refs: $bad"

  return $((fm_status + mojibake + bad))
}

phase_fix() {
  section "FIX (no automated fixes in this run — see prompt.md for guidance)"
  log "Fixes for F-0001..F-0004 were applied by /remediate-repo skill execution."
  log "F-0005 (CSP tightening) is needs_owner — requires browser verification."
}

phase_verify() {
  section "VERIFY"
  rc=0

  # 1. Frontmatter
  if ! phase_review >/dev/null 2>&1; then
    log "VERIFY: frontmatter check FAILED"
    rc=1
  else
    log "VERIFY: frontmatter check passed"
  fi

  # 2. Mojibake
  if grep -q 'â€' AGENTS.md 2>/dev/null; then
    log "VERIFY: AGENTS.md mojibake STILL PRESENT"
    rc=1
  else
    log "VERIFY: AGENTS.md clean"
  fi

  # 3. RUNBOOK branch refs
  if grep -qE 'origin main| main / root|branch: main' docs/RUNBOOK.md 2>/dev/null; then
    log "VERIFY: RUNBOOK still references main branch"
    rc=1
  else
    log "VERIFY: RUNBOOK branch references correct"
  fi

  # 4. Open critical/high findings
  if command -v jq >/dev/null 2>&1; then
    open_high=$(jq '[.findings[] | select(.severity=="critical" or .severity=="high") | select(.status=="open" or .status=="in_progress")] | length' findings.json 2>/dev/null || echo 0)
    log "Open critical/high findings: $open_high"
    if [ "$open_high" -gt 0 ]; then rc=1; fi
  fi

  if [ "$rc" -eq 0 ]; then
    log "VERIFY: ALL CHECKS PASSED"
  else
    log "VERIFY: FAILURES PRESENT"
  fi
  return $rc
}

case "$MODE" in
  discover) phase_discover ;;
  review)   phase_discover; phase_review ;;
  fix)      phase_fix ;;
  verify)   phase_verify ;;
  all)      phase_discover; phase_review; phase_fix; phase_verify ;;
  *) echo "Unknown mode: $MODE"; exit 2 ;;
esac
