---
title: "Code Review Report — aresmaxs.com"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---

# Code Review Report — aresmaxs.com

> Generated: 2026-05-12T12:56:27Z by `/remediate-repo` (single-iteration end-to-end run)

## 1. Executive Summary

`aresmaxs.com` is a static brand-landing site (HTML/CSS/JS) plus a documentation suite and an agency-governance manifest layer. No build system. CI is limited to Markdown lint, an AI doc review gate, and a swarm-governance schema gate.

This iteration found **5 findings** — 0 critical, 1 high, 3 medium, 1 low. **4 fixed in this run, 1 left as `needs_owner`** (CSP tightening requires live-browser validation outside the scope of a single-shot doc/file edit).

| Severity | Count | Status |
|---|---|---|
| Critical | 0 | — |
| High | 1 | fixed |
| Medium | 3 | fixed |
| Low | 1 | needs_owner |
| Info | 0 | — |

**Repo health:** before this run, any PR touching `docs/` would have failed `doc-lint.yml`. After this run, the doc suite is CI-clean, agency-governance manifest mojibake is fixed, the runbook reflects the real default branch, and `SECURITY.md` matches the actual CSP.

## 2. Repo Standards & Compliance Targets

Discovered from this repo (no invented baselines):

- **`.github/workflows/doc-lint.yml`** — `markdownlint-cli` with `.markdownlint.json` config; embedded Python validator that requires YAML frontmatter with `title`, `owner`, `status` ∈ `{Draft, Active, Review, Deprecated, Archived}`, `last_reviewed`. Advisory broken-link check.
- **`.github/workflows/swarm-gate.yml`** — Verifies `AGENT.md` (with fields `repo:`, `type:`, `description:`, `authority:`, `max_auto_level:`, `commands:`) and `AGENTS.md` (with `schema_version:` and four role sections).
- **`.github/workflows/ai-review.yml`** — Optional AI doc review (gated by `vars.AI_REVIEW_ENABLED`).
- **`.markdownlint.json`** — MD013/MD033/MD041 disabled; otherwise defaults.
- **`AGENT.md` authority ceiling:** `max_auto_level: 1`, `always_open_pr: true` — agents must open PRs, not push to master.
- **CSP** (in `index.html`) — current production CSP enforced by `<meta http-equiv>`.

## 3. Detected Tooling & Commands

| Stage | Command | Source |
|---|---|---|
| Lint markdown | `markdownlint 'docs/**/*.md' '*.md' --config .markdownlint.json --ignore node_modules` | doc-lint.yml |
| Validate frontmatter | embedded Python in doc-lint.yml | doc-lint.yml |
| Swarm schema check | embedded Python in swarm-gate.yml | swarm-gate.yml |
| Lighthouse (manual) | `npx lighthouse https://aresmaxs.com` | docs/TEST_STRATEGY.md |
| Link check (manual) | `npx linkinator https://aresmaxs.com --recurse` | docs/TEST_STRATEGY.md |

## 4. Unfinished/Broken Code Inventory

- **TODO/FIXME/HACK markers:** 0 (clean)
- **Placeholder/lorem text:** `index.html` has `placeholder=` HTML attributes on the contact form — these are intentional UI placeholders, not unfinished work.
- **Frontmatter drift:** 10 of 11 doc files were non-compliant before this run (see F-0002).
- **Encoding artifact:** 1 occurrence of UTF-8 mojibake in `AGENTS.md` (see F-0001).
- **Doc-vs-implementation drift:** SECURITY.md (CSP) and RUNBOOK.md (branch) misaligned with code (see F-0003, F-0004).
- **CSP over-permissive:** Unused cdnjs whitelist (see F-0005).

## 5. Findings by Severity

### High

- **F-0002** — `doc-lint.yml` frontmatter schema fails on 10 of 11 doc files. **Fixed.**

### Medium

- **F-0001** — AGENTS.md UTF-8 mojibake `â€"` → `—`. **Fixed.**
- **F-0003** — `docs/SECURITY.md` misstates the actual CSP. **Fixed** (doc now mirrors `index.html` literally + adds Hardening Backlog).
- **F-0004** — `docs/RUNBOOK.md` references `main` branch on a `master`-default repo. **Fixed** (4 occurrences).

### Low

- **F-0005** — CSP whitelists unused `https://cdnjs.cloudflare.com` in `script-src`. **`needs_owner`** — requires live-site browser test before merging the CSP edit. Recommendation captured in `docs/SECURITY.md → Hardening Backlog`.

## 6. Fix Plan & Sequencing

Executed in this run, in order:

1. F-0001 — AGENTS.md mojibake
2. F-0002 — doc frontmatter (10 files)
3. F-0003 — docs/SECURITY.md CSP doc drift
4. F-0004 — docs/RUNBOOK.md branch references

Deferred:

5. F-0005 — CSP tightening (needs browser test)

## 7. Verification Plan

```bash
# 1. Frontmatter schema (mirrors doc-lint.yml)
python3 - << 'PY'
import re, os
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
PY
# Expected: OK

# 2. Mojibake check
grep -P '[^\x00-\x7F]' AGENTS.md | grep -c 'â€'
# Expected: 0

# 3. Runbook branch references
grep -nE 'origin main| main / root|branch: main' docs/RUNBOOK.md
# Expected: no matches

# 4. SECURITY.md CSP mirrors index.html
diff <(grep -A0 'script-src' docs/SECURITY.md | head -1) <(grep -o 'script-src[^;]*' index.html)
# Expected: no semantic difference
```

## 8. Changelog of Fixes

| Commit | Findings | Files |
|---|---|---|
| (pending — see Commit Discipline) | F-0001, F-0002, F-0003, F-0004 | AGENTS.md, docs/{ARCHITECTURE,DEPLOYMENT,DEVELOPMENT,MANIFEST,PRD,ROADMAP,RUNBOOK,SECURITY,TEST_STRATEGY}.md, docs/ADR/001-initial-architecture.md |

## 9. Open Questions / Needs Owner

- **F-0005 (CSP tightening):** Requires live-browser test on Chrome/Firefox/Safari. Recommend a follow-up branch `chore/csp-tighten` that drops `cdnjs.cloudflare.com` and Lighthouse-validates the page.
- **Frontmatter key convention:** This repo mixes `last_reviewed` (CI-required) with `last-updated` (legacy). The fix used the CI-required key but left existing `last-updated` fields in place to avoid loss-of-history. Consider an agency-wide migration pass.
- **`docs/MANIFEST.md` health table** shows 9/16 (56%) docs present — 7 docs (`api.md`, `data-model.md`, `QUALITY.md`, `testing.md`, `configuration.md`, `OBSERVABILITY.md`, `RUNBOOKS` directory) are listed as Missing. Out of scope for this single-iteration remediation; flag for next pass.
