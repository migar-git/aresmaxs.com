---
title: "Remediation Prompt — aresmaxs.com"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---

# Remediation Prompt — aresmaxs.com

Maps 1:1 to `findings.json`. Use this file as the prompt input for any follow-up agent that needs to re-apply or extend remediation.

## Table of Contents

- [How to Run](#how-to-run)
- [F-0001 — AGENTS.md UTF-8 mojibake](#f-0001--agentsmd-utf-8-mojibake)
- [F-0002 — Doc frontmatter non-compliant with doc-lint.yml](#f-0002--doc-frontmatter-non-compliant-with-doc-lintyml)
- [F-0003 — docs/SECURITY.md misstates the CSP](#f-0003--docssecuritymd-misstates-the-csp)
- [F-0004 — docs/RUNBOOK.md references wrong branch (main vs master)](#f-0004--docsrunbookmd-references-wrong-branch-main-vs-master)
- [F-0005 — CSP allows unused cdnjs.cloudflare.com](#f-0005--csp-allows-unused-cdnjscloudflarecom)

## How to Run

```bash
# Discover only
bash run_review.sh --mode discover

# Full review (read-only) — writes findings.json + report
bash run_review.sh --mode review

# Verify (exits non-zero if open critical/high findings remain)
bash run_review.sh --mode verify

# All phases sequentially
bash run_review.sh --mode all
```

Windows / PowerShell:

```powershell
pwsh ./run_review.ps1 -Mode all
```

---

## F-0001 — AGENTS.md UTF-8 mojibake (Severity: Medium | Category: Docs)

### Context

`AGENTS.md` is parsed by `.github/workflows/swarm-gate.yml` and used as a machine-readable agent manifest across the agency. Line 19 contained `â€"` (CP1252 em-dash double-encoded as UTF-8) instead of `—`.

### Required Changes

1) Edit `AGENTS.md` line 19: replace `â€"` with `—` (em-dash, U+2014).

### Acceptance Criteria

- [ ] `grep -c 'â€' AGENTS.md` returns 0.
- [ ] Swarm-gate.yml still validates AGENTS.md schema (no regression).

### Verification

- Command: `grep -P '[^\x00-\x7F]' AGENTS.md | grep -c 'â€'`
- Expected: `0`

### Commit Guidance

- Message: `fix(F-0001): repair UTF-8 mojibake in AGENTS.md canonical_purpose`
- Notes: 1-byte-pattern fix; no other changes.

### Rollback

- `git revert <commit>` if any swarm-gate regression appears.

---

## F-0002 — Doc frontmatter non-compliant with doc-lint.yml (Severity: High | Category: Build)

### Context

`.github/workflows/doc-lint.yml` runs on every PR touching `docs/**` or `*.md` and requires every doc file to have YAML frontmatter with `title`, `owner`, `status` ∈ `{Draft, Active, Review, Deprecated, Archived}`, and `last_reviewed`. 10 of 11 docs failed this schema.

### Required Changes

1) Prepend canonical frontmatter to docs without it:
   - `docs/ARCHITECTURE.md`
   - `docs/DEPLOYMENT.md`
   - `docs/RUNBOOK.md`
   - `docs/SECURITY.md`
   - `docs/TEST_STRATEGY.md`
   - `docs/ADR/001-initial-architecture.md`

2) Upgrade frontmatter where `status: "Current"` (invalid) was set:
   - `docs/DEVELOPMENT.md`
   - `docs/MANIFEST.md`
   - `docs/ROADMAP.md`

3) Add missing `last_reviewed` to `docs/PRD.md`.

Canonical block:

```yaml
---
title: "<Doc Title>"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---
```

### Acceptance Criteria

- [ ] Validator (re-implementation of doc-lint.yml's check) returns `OK: all 11 docs pass`.
- [ ] `markdownlint` still passes (no MD violations introduced by frontmatter).

### Verification

- Command: See `CODE_REVIEW_REPORT.md → § 7.1`.
- Expected: `OK`

### Commit Guidance

- Message: `fix(F-0002): bring doc frontmatter into doc-lint.yml compliance`
- Notes: One commit covering all 10 files — they're a single semantic change (CI-schema compliance).

### Rollback

- `git revert <commit>` — frontmatter additions are non-load-bearing for site rendering.

---

## F-0003 — docs/SECURITY.md misstates the CSP (Severity: Medium | Category: Security)

### Context

`docs/SECURITY.md` claimed `script-src 'self'` and listed only four directives. The real CSP (in `index.html` line 5) is:

```
default-src 'self';
script-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com;
style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
font-src 'self' https://fonts.gstatic.com;
img-src 'self' data: https:;
connect-src 'self';
object-src 'none';
base-uri 'self';
```

Plus, an inline `<script type="application/ld+json">` block exists at index.html:27 — contradicting the doc's "no inline scripts" claim.

### Required Changes

1) Replace the Content Security Policy section with the literal current CSP.
2) Add a Hardening Backlog table listing three concrete tightening actions tied to F-0005.

### Acceptance Criteria

- [ ] Section verbatim mirrors `index.html` CSP.
- [ ] Hardening Backlog table present.

### Verification

- Command: `grep -A 12 'Current policy' docs/SECURITY.md`
- Expected: includes the same directives as `index.html` line 5.

### Commit Guidance

- Message: `fix(F-0003): align docs/SECURITY.md with actual CSP in index.html`
- Notes: Doc-only change; no code/HTML changes.

### Rollback

- Trivial revert — no runtime impact.

---

## F-0004 — docs/RUNBOOK.md references wrong branch (main vs master) (Severity: Medium | Category: Docs)

### Context

The repo's default branch is `master` (confirmed by `git symbolic-ref refs/remotes/origin/HEAD`). RUNBOOK.md referenced `main` in 4 places — Hosting line, two `git push origin main` blocks, and one "Settings → Pages → source: main" line.

### Required Changes

1) Replace every occurrence of `main` with `master` in `docs/RUNBOOK.md` where the reference is to the git/Pages branch.

### Acceptance Criteria

- [ ] `grep -nE 'origin main| main / root|branch: main' docs/RUNBOOK.md` returns no matches.
- [ ] Other words containing "main" (e.g., "maintain") are unaffected.

### Verification

- Command: `grep -nE 'origin main| main / root|branch: main' docs/RUNBOOK.md`
- Expected: no matches.

### Commit Guidance

- Message: `fix(F-0004): correct branch references in RUNBOOK from main to master`

### Rollback

- Single-file revert.

---

## F-0005 — CSP allows unused cdnjs.cloudflare.com (Severity: Low | Category: Security | Status: needs_owner)

### Context

`index.html` line 5 has `script-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com`. A repo-wide grep for `cdnjs` and `cloudflare` shows zero actual consumers of that origin. The whitelist is dead weight.

### Required Changes

1) Edit `index.html` CSP to remove `https://cdnjs.cloudflare.com` from `script-src`.
2) (Stretch) Replace `'unsafe-inline'` on `script-src` with `'sha256-<hash>'` of the inline JSON-LD block at line 27.
3) Update `docs/SECURITY.md` Hardening Backlog row to "Done".

### Acceptance Criteria

- [ ] Live site renders without CSP violations on Chrome, Firefox, Safari.
- [ ] Lighthouse score within 1 point of pre-change baseline.

### Verification

- Open `https://aresmaxs.com` with DevTools Console open — expect zero CSP violation reports.
- `npx lighthouse https://aresmaxs.com --output json | jq '.categories.performance.score'`

### Commit Guidance

- Message: `fix(F-0005): tighten CSP — drop unused cdnjs whitelist`
- Notes: ⚠ Requires live-browser test before merging. Do NOT batch with the doc-only fixes above.

### Rollback

- Single-line revert in `index.html` if any CSP violation surfaces in the wild.
