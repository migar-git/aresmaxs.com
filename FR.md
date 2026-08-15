# Aresmaxs.com Feature Requests

<!-- REGROUND:reground-20260815-python-fleet:BEGIN -->

## Re-Grounding 2026-08-15 — Autonomous Fleet Pass

> **Run:** `reground-20260815-python-fleet` · **Method:** static forensic recon of all 59 git repos under `C:\Users\mcgac\Python`
> (tree + manifests + compose + git metadata + targeted greps via Windows-MCP; **no code executed this pass**).
> **Execution contract:** [`FRSP.md`](FRSP.md) — the resident self-agent system prompt generated alongside this block.

### Verified identity (2026-08-15)

Aresmax Digital brand site (aresmaxs.com, GitHub Pages): cinematic single-page brand experience, 4 HTML pages, CSP meta, reduced-motion support.

### Evidence snapshot

| Field | Value |
|---|---|
| Class | Static/managed website |
| Branch @ recon | `master` |
| Last commit observed | 2026-07-27 |
| Stack | Static HTML/CSS/vanilla JS |
| Ports/services declared | none declared |
| Test posture | 3 workflows (doc-lint family) |
| LLM posture | CI-level only |
| MCP posture | n/a |
| Dashboard posture | arescore registration |

### Prior-content status

The body below this block is the prior audit register (last authored ~2026-07-03/04, 229 lines). It is preserved verbatim per the fleet data-retention law. Every claim in it is now classified **STALE-UNVERIFIED** until re-proven by the FRSP execution loop — the repo has moved (last commit 2026-07-27).

### Universal mandate assessment (fleet standard M-01..M-10)

| ID | Mandate | Status | Evidence / note |
|---|---|---|---|
| M-01 | Repo self-agent | PARTIAL | AGENT.md/CLAUDE.md governance present fleet-wide; FRSP.md (this pass) is now the executable self-agent contract |
| M-02 | Local-LLM capability (via canonical provider) | N-A/CI-LEVEL | LLM used in CI/build lanes only — correct for this repo class; runtime consumption not required |
| M-03 | Local-LLM management reachable | N-A | Managed centrally by olaman; this repo consumes nothing at runtime |
| M-04 | MCP surface | N-A | n/a |
| M-05 | 3-click dashboard access | PARTIAL | arescore registration; 3-click rule unproven — audit required |
| M-06 | Dedup/consolidate/reuse | OPEN | 1 directive(s) — see FRSP.md §5 |
| M-07 | 100% coverage, all green/clean | UNPROVEN | 3 workflows (doc-lint family) — no verified 100% run on record |
| M-08 | Live operational validation | UNVERIFIED | This pass was static (no code executed); runtime proof owed by FRSP execution |
| M-09 | Traceability & auditability | MINIMAL | Observability signals vary; correlation-ID + decision-record standard mandated |
| M-10 | Total data retention | POLICY-SET | Retention law encoded in FRSP.md §12; archive-never-destroy from this date |

### Deduplication / consolidation directives (repo-specific)

- **DD-01:** Site-kit extraction (see anavr.in)

### Re-grounded gap register (adds to, never replaces, the register below)

- **RG-01:** Same as site-kit siblings

### Fleet context this repo must honor

- Canonical local-LLM provider: **olaman (Ollama gateway/control plane, port 8030) fronting host Ollama at 127.0.0.1:11434**
- Canonical fleet dashboard/command center: **arescore (ClawMedia command center, app/server.js :8889; Arescore hub seed http://127.0.0.1:8890/)**
- Canonical skills SSOT: **agency (SSOT skill registry, 708-skill capability manifest)**
- Known fleet port collisions (resolve via the arescore port registry): 8030: olaman vs dev-analytics api; 8741: freeai backend vs myskills; 8000: mia, lab, peni, myprd backends (+fira internal); 8028: fira frontend vs midas (full list in FRSP.md §1)

<!-- REGROUND:reground-20260815-python-fleet:END -->


## Review Metadata

- **Review date:** 2026-07-03
- **Repo root:** `C:\Users\mcgac\Python\aresmaxs.com` (bash mirror: `/sessions/epic-tender-pasteur/mnt/Python/aresmaxs.com/`)
- **Languages/frameworks:** Static HTML5/CSS3 + dependency-free vanilla JavaScript, no build tooling, no package.json. Deployed via GitHub Pages with a custom domain (`CNAME` file contains `aresmaxs.com`; git remote is `https://github.com/migar-git/aresmaxs.com.git`, default branch `master`).
- **App type:** Brand/marketing landing page for "Aresmax Digital" (a single-page site with animated hero, custom cursor, scroll-reveal sections) plus three legal pages (`privacy.html`, `terms.html`, `refund.html`). Matches the assignment's expectation of a marketing/static site with web-appropriate FRs.
- **Review mode:** Blitz — single-session, sampled evidence.
- **Commands run:** No code execution, installs, or git mutations performed (hard rule). `mcp__workspace__bash` was contended when this repo's review began (`RPC error -1: process already running`), so inspection was performed entirely via `Glob`/`Grep`/`Read` file tools, consistent with the instruction that file tools are sufficient. Git identity (remote URL, default branch) was read directly from `.git/config` rather than via `git` CLI, per the fallback method specified in the task.
- **Tests/CI discovered:** Three GitHub Actions workflows, identical in structure/purpose to the sibling `aresmax-blog` repo — `doc-lint.yml` (markdownlint + YAML-frontmatter validation, scoped to `docs/**`/`*.md`), `ai-review.yml` (AI doc-quality gate referencing a `scripts/ai-review.sh` that does not exist in this repo, confirmed absent), and `swarm-gate.yml` (validates `AGENT.md`/`AGENTS.md` presence/schema — internal fleet governance, not site quality). **No workflow tests the actual website** — no Lighthouse, no accessibility audit, no link-checker, no visual regression — despite `docs/TEST_STRATEGY.md` specifying all of these in detail with exact commands.
- **Confidence:** High — the site is small (4 HTML pages, 1 CSS file, 1 JS file) and was read in full or near-full. A prior self-audit (`findings.json`, dated 2026-05-12) exists and independently corroborates one of the findings below (unused CSP script-source whitelist entry, status `needs_owner` — i.e., already flagged and still open).

## Existing Capabilities Found

- **SEO fundamentals:** Unique title, meta description/keywords, canonical-equivalent OG `url`, Open Graph and Twitter Card tags, and valid Schema.org `Organization` JSON-LD markup (with `sameAs` links to 5 social profiles) are all present on `index.html`. `sitemap.xml` and `robots.txt`-equivalent crawl guidance exist (sitemap lists 5 URLs).
- **Security headers (meta-tag level):** A CSP is set via `<meta http-equiv>`, scoped to `default-src 'self'` with an `object-src 'none'` hardening directive.
- **Accessibility baseline:** `prefers-reduced-motion: reduce` media query is implemented in `style.css` (line 1102), correctly disabling animations for users who opt out — this satisfies a specific requirement called out in `docs/TEST_STRATEGY.md` §2. Social icon links and the mobile menu toggle carry `aria-label` attributes.
- **Documentation governance + self-audit:** Same structured `docs/` tree and ADR log as the sibling blog repo, plus a dated `findings.json` self-audit that already fixed 4 issues (UTF-8 mojibake in `AGENTS.md`, frontmatter violations, a security-doc-vs-code CSP mismatch, and a stale `main`-vs-`master` branch reference in `docs/RUNBOOK.md`) — evidence of an active quality process.
- **Legal/compliance pages:** `privacy.html`, `terms.html`, and `refund.html` exist and are referenced in the sitemap and in `docs/SECURITY.md`'s "Privacy Pages" section.
- **Dependency-free JS:** `script.js` implements custom cursor, mobile menu toggle, and (per `docs/TEST_STRATEGY.md`) IntersectionObserver scroll reveals with zero external library dependencies, matching the documented "no external JS frameworks" code standard in `CONTRIBUTING.md`.

## Evidence Ledger

| Evidence ID | Area | Evidence Type | File/Path/Command | Finding | Confidence |
|---|---|---|---|---|---|
| EV-01 | Test strategy vs. CI reality | Read | `docs/TEST_STRATEGY.md` (all sections) vs. `.github/workflows/*.yml` | TEST_STRATEGY.md mandates Lighthouse (Perf/A11y/BP ≥90, SEO ≥95), axe accessibility testing, 60fps/CLS animation verification, linkinator link-checking, and Playwright visual regression — none of the 3 discovered workflows implement any of these | High |
| EV-02 | Broken social-preview image | Grep + Glob | `index.html` line 15 (`og:image` → `https://aresmaxs.com/og-image.jpg`); `Glob` for `og-image.jpg` at repo root | The referenced OG image file does not exist anywhere in the repo; since GitHub Pages serves only committed files, any social share (Twitter/Facebook/LinkedIn card) will show a broken image | High |
| EV-03 | Broken Schema.org logo reference | Read + Glob | `index.html` lines 26-33 (`"logo": "https://aresmaxs.com/logo.png"`); `Glob` for `logo.png` at repo root | The referenced logo file does not exist anywhere in the repo; Google's Rich Results structured-data validation for Organization markup expects a resolvable `logo` URL, and this will fail | High |
| EV-04 | Unused CSP whitelist entry | Read | `index.html` line 5; `findings.json` F-0005 (status: `needs_owner`) | `script-src` whitelists `https://cdnjs.cloudflare.com` but nothing in the repo loads from that host (confirmed by the prior audit's own repo-wide grep, and independently by this review's read of `script.js` showing zero external script tags) — this finding is already logged in the repo's own audit trail and remains unresolved | High |
| EV-05 | License | Glob | `LICENSE*` at repo root | No LICENSE file found | High |
| EV-06 | Code ownership | Glob | `CODEOWNERS` at repo root and `.github/` | No CODEOWNERS file found | High |
| EV-07 | Pre-commit hooks | Glob | `.pre-commit-config.yaml` at repo root | Not found; same gap pattern as sibling `aresmax-blog` repo (frontmatter/markdown validation only runs at CI/PR time, not locally before commit) | High |
| EV-08 | Mobile menu ARIA state | Grep | `aria-expanded` across `*.html` | Zero matches; the `.menu-toggle` button (`index.html` line 51) has an `aria-label` but no `aria-expanded` attribute reflecting open/closed state, which is a WCAG 4.1.2 (Name, Role, Value) consideration for a toggle control that changes page state | Medium |
| EV-09 | AI-review script dependency | Glob | `scripts/ai-review.sh` | Referenced by `.github/workflows/ai-review.yml` line 42 but does not exist in this repo; the "cloud" review branch always falls through to an echo no-op | High |
| EV-10 | Sitemap freshness | Read | `sitemap.xml` `lastmod` values (all `2026-02-14`) vs. `docs/SECURITY.md`/`findings.json` `last_reviewed`/`generatedAt` dates (2026-05-12) | Sitemap `lastmod` dates were not updated during the documented 2026-05-12 remediation pass that touched `docs/SECURITY.md` and other files, suggesting sitemap maintenance is not part of the update workflow | Low — flagged as needs-confirmation since `lastmod` accuracy has limited practical SEO impact and no direct evidence shows this caused a real crawl problem |

## Threat Model Summary (STRIDE-brief)

- **Spoofing:** Low relevance — no authentication surface.
- **Tampering:** CSP with `object-src 'none'` limits injection vectors; the unused `cdnjs.cloudflare.com` script-source whitelist (EV-04) is the one concrete finding here — it doesn't cause active harm today but widens the available payload-hosting surface should an inline-script injection vulnerability ever be introduced.
- **Repudiation:** N/A — static site, no transactional logging needed.
- **Information Disclosure:** No secrets/API keys found embedded in any HTML/JS (`docs/SECURITY.md`'s "no server-side secrets" claim holds up under sampled review). Legal pages (`privacy.html`, `terms.html`, `refund.html`) exist as required disclosures.
- **Denial of Service:** Minimal — static site on GitHub Pages CDN.
- **Elevation of Privilege:** N/A.

## AI Governance Summary

Not applicable as a product capability. As with the sibling `aresmax-blog` repo, the `agents/`, `audit/`, `prompts/`, `skills/` directories and `ai-review.yml`/`swarm-gate.yml` workflows are meta-tooling for how AI coding assistants contribute to this repo, not an AI feature delivered to site visitors. No AI-governance FRs are raised.

## Competitive Benchmark Matrix

| Capability | Aresmaxs.com (verified) | Typical brand-landing-page competitor baseline |
|---|---|---|
| SEO meta/OG/Schema.org markup | Present, well-formed | Standard — met |
| Working social-share preview image | **Broken** (referenced file absent) | A working `og:image` is table stakes for any brand site sharing links on social platforms |
| Automated Lighthouse/perf gate | **Missing** (documented, not implemented) | Common for brand sites with animation-heavy hero sections where perf regressions are a known risk |
| Automated accessibility audit | **Missing** (documented, not implemented) | `axe-core` CI is increasingly standard for public brand sites |
| CSP least-privilege | Partial — one unused entry (`cdnjs.cloudflare.com`) already flagged internally but unresolved | Best-practice CSPs whitelist only actively-used hosts |
| License clarity | **Missing** | Common for public GitHub repos, even brand-only sites |

## Gap Analysis Summary

Like its sibling `aresmax-blog`, this repo's core weakness is that `docs/TEST_STRATEGY.md` specifies a thorough, concrete test regime (exact Lighthouse/axe/linkinator/Playwright commands) that is never wired into the 3 actual CI workflows, all of which govern documentation and AI-agent metadata rather than the shipped site. Layered on top of that structural gap are two concrete, currently-broken marketing assets — the Open Graph image and the Schema.org logo — both referencing files that don't exist in the repo, meaning every social-media share of this domain currently renders with a broken preview image. The repo's own prior self-audit already caught and left open one hygiene item (unused CSP host), which this review corroborates and elevates.

## Feature Requests

### FR-001

**Description:** Add the missing `og-image.jpg` (referenced at `index.html` line 15, `https://aresmaxs.com/og-image.jpg`) to the repository at the correct path so social-media link previews render correctly, and add a CI check that fails if any `og:image`/`twitter:image`/Schema.org `logo` URL referenced in HTML resolves to a file absent from the repo.
**Why It Matters:** This is a live, user-visible defect on a production marketing domain: every time this URL is shared on Twitter/X, Facebook, LinkedIn, or any platform that renders Open Graph previews, the preview image will be broken, directly undermining the brand-presentation purpose this site exists for.
**Verification Evidence:** Read of `index.html` line 15 confirms the reference; `Glob` for `og-image.jpg` at repo root confirms the file is absent (EV-02).
**Evidence IDs:** EV-02
**Priority:** P0
**Category:** Marketing / Brand Integrity
**ROI Score:** 7/10 — this is the site's entire purpose (brand presentation); a broken social-share image directly undermines every inbound link shared on social platforms, and the fix is trivial (add one image file).
**Risk Score:** 3/10 — low complexity, purely additive (add an asset file), no breaking change.
**Dependencies:** Needs the actual brand asset (a 1200x630px OG image is the standard convention) to be produced/sourced — likely already exists as a design asset outside this repo.
**Competitive Reference:** Universal best practice for any brand/marketing site; broken OG images are one of the most common and most visible defects flagged by social-share debuggers (e.g., Twitter Card Validator, Facebook Sharing Debugger).
**Security/Privacy Impact:** None directly.
**Rollout Readiness:** High — single asset file addition.
**Validation Gates:** (1) Facebook Sharing Debugger and Twitter Card Validator both render the image correctly for `https://aresmaxs.com/`; (2) a new CI step verifies every `og:image`/`logo` URL referenced in shipped HTML corresponds to a file present in the repo; (3) manual visual check confirms the image matches brand guidelines.
**Acceptance Criteria:** (1) `og-image.jpg` exists at the repo root and is served at `https://aresmaxs.com/og-image.jpg`; (2) social-share preview tools render the image without error; (3) a CI check (new or added to an existing workflow) fails the build if a referenced OG/Twitter/Schema.org image path doesn't resolve to a committed file.

### FR-002

**Description:** Add the missing `logo.png` (referenced in the Schema.org `Organization` JSON-LD at `index.html` line 33, `https://aresmaxs.com/logo.png`) to the repository, and validate the fix using Google's Rich Results Test.
**Why It Matters:** Google's structured-data guidelines expect the `logo` property of an `Organization` schema to resolve to an actual image; a broken reference means this site's Schema.org markup will fail rich-result validation, reducing the likelihood of enhanced search-result presentation (e.g., knowledge panel logo).
**Verification Evidence:** Read of `index.html` lines 26-33 (JSON-LD block) confirms the reference; `Glob` for `logo.png` at repo root confirms absence (EV-03).
**Evidence IDs:** EV-03
**Priority:** P0
**Category:** SEO / Structured Data
**ROI Score:** 6/10 — directly affects search-engine rich-result eligibility for the brand's own domain; trivial fix.
**Risk Score:** 3/10 — low complexity, additive only.
**Dependencies:** Same brand-asset sourcing need as FR-001; could be delivered in the same PR.
**Competitive Reference:** Standard SEO hygiene per Schema.org/Google structured-data documentation for Organization markup.
**Security/Privacy Impact:** None.
**Rollout Readiness:** High.
**Validation Gates:** (1) Google Rich Results Test (`search.google.com/test/rich-results`) validates the Organization markup with no logo-related errors, per `docs/TEST_STRATEGY.md` §7's own stated verification method; (2) the file is confirmed reachable at the exact URL referenced in the JSON-LD; (3) a CI structured-data-asset check (shared with FR-001) passes.
**Acceptance Criteria:** (1) `logo.png` exists at repo root and is served at `https://aresmaxs.com/logo.png`; (2) Google's Rich Results Test shows no errors for the Organization markup; (3) the fix is verified using the exact tool `docs/TEST_STRATEGY.md` §7 already specifies.

### FR-003

**Description:** Add a Lighthouse CI job (e.g., `treosh/lighthouse-ci-action`) running against the live `https://aresmaxs.com` domain, enforcing the Performance ≥90, Accessibility ≥90, Best Practices ≥90, SEO ≥95 thresholds already specified in `docs/TEST_STRATEGY.md` §1, with specific attention to CLS from the animated hero section as the doc itself flags.
**Why It Matters:** This is documented as the "Primary Quality Gate" with an exact command already written out, but no CI job runs it — for a site whose own test strategy specifically calls out animation-related performance risk ("CSS animations must not cause Lighthouse performance regressions"), this is a foundational, currently-unenforced gate.
**Verification Evidence:** `docs/TEST_STRATEGY.md` lines 16-31; `.github/workflows/` contains only `doc-lint.yml`, `ai-review.yml`, `swarm-gate.yml` (EV-01).
**Evidence IDs:** EV-01
**Priority:** P0
**Category:** Web Quality / Performance
**ROI Score:** 7/10 — brand perception is directly tied to page performance and polish for a site whose entire value proposition is "AI-powered digital enterprise" positioning; the animated, JS-heavy hero section is exactly the kind of feature likely to regress performance without a gate.
**Risk Score:** 3/10 — low complexity, drop-in CI action.
**Dependencies:** None.
**Competitive Reference:** Standard for any performance-conscious brand site in 2026; directly addresses the CLS risk the site's own animated hero section introduces.
**Security/Privacy Impact:** Best Practices category also catches some security-adjacent issues (mixed content, deprecated APIs).
**Rollout Readiness:** High — exact command already documented.
**Validation Gates:** (1) CI job runs against the live domain and produces a report; (2) thresholds match `docs/TEST_STRATEGY.md` exactly; (3) CLS is specifically tracked given the documented animation risk.
**Acceptance Criteria:** (1) A new workflow runs Lighthouse against `https://aresmaxs.com` on the schedule specified ("Monthly") and/or relevant PRs; (2) the job fails below documented thresholds; (3) CLS score is reported distinctly given the hero-animation risk called out in the test strategy; (4) `docs/TEST_STRATEGY.md` is updated from aspirational to implemented.

### FR-004

**Description:** Remove the unused `https://cdnjs.cloudflare.com` entry from the CSP `script-src` directive in `index.html`, closing out the repo's own previously-logged, still-open finding (`findings.json` F-0005).
**Why It Matters:** The repo's own prior audit already identified this exact issue and left it in `needs_owner` status: nothing in the codebase loads from cdnjs.cloudflare.com, so the whitelist entry only exists to widen the CSP's attack surface for a hypothetical future inline-script injection.
**Verification Evidence:** Read of `index.html` line 5 confirms the whitelist entry; `findings.json` F-0005 (status `needs_owner`) documents the exact same finding with a verification method already prescribed by the repo's own tooling (EV-04).
**Evidence IDs:** EV-04
**Priority:** P1
**Category:** Security Hardening (CSP)
**ROI Score:** 4/10 — narrow, low-likelihood risk reduction, but essentially zero-cost (one-line edit) and closes a finding the repo already committed to fixing internally.
**Risk Score:** 3/10 — the risk of the current unused whitelist entry is low-probability/low-impact on its own, but leaving a self-identified, unresolved finding open indefinitely is itself a process-risk indicator.
**Dependencies:** None — the repo's own `findings.json` F-0005 already lays out the exact remediation plan (edit CSP, test on Chrome/Firefox/Safari, run Lighthouse for score parity, update `docs/SECURITY.md` Hardening Backlog).
**Competitive Reference:** OWASP CSP guidance (principle of least privilege for allowlisted script sources).
**Security/Privacy Impact:** Reduces the CSP's available payload-hosting surface should an inline-script XSS vulnerability ever be introduced elsewhere on the site.
**Rollout Readiness:** High — single CSP token removal, verification steps already documented by the repo's own audit.
**Validation Gates:** (1) Opening the live site with DevTools open shows no new CSP violation reports after the change (per `findings.json` F-0005's own verification step); (2) Lighthouse score parity within 1 point of baseline; (3) `docs/SECURITY.md`'s Hardening Backlog table is updated to mark this item complete.
**Acceptance Criteria:** (1) `cdnjs.cloudflare.com` is removed from the `script-src` CSP directive in `index.html`; (2) the site renders and functions identically post-change (manual cross-browser check per the repo's own test strategy); (3) `findings.json` F-0005 status is updated from `needs_owner` to `fixed` with a commit reference; (4) `docs/SECURITY.md`'s Hardening Backlog table reflects the change.

### FR-005

**Description:** Add an automated accessibility audit (axe-core or Lighthouse-accessibility-category) to CI covering the homepage, per `docs/TEST_STRATEGY.md` §2's explicit requirement, and add `aria-expanded` state management to the mobile menu toggle button.
**Why It Matters:** `docs/TEST_STRATEGY.md` specifically calls for axe DevTools testing including keyboard navigation and the gold-on-black contrast ratio check, but no automated check exists; separately, the mobile menu toggle (a control that changes visible page state) lacks an `aria-expanded` attribute, a WCAG 4.1.2 consideration for assistive-technology users.
**Verification Evidence:** `docs/TEST_STRATEGY.md` lines 33-39; Grep for `aria-expanded` across all HTML returned zero matches while the `.menu-toggle` button (line 51) has only `aria-label` (EV-08); no accessibility CI tooling found anywhere in the repo.
**Evidence IDs:** EV-08, EV-01
**Priority:** P1
**Category:** Accessibility (a11y)
**ROI Score:** 5/10 — trust/UX-weighted; moderate effort, directly closes a documented-but-unimplemented test category and a concrete, narrow ARIA gap.
**Risk Score:** 3/10 — low complexity for both the CI addition and the ARIA fix.
**Dependencies:** Can share tooling/CI job with FR-003 (Lighthouse's Accessibility category) or run as a standalone axe-core check.
**Competitive Reference:** WCAG 2.2 AA is the common baseline target for brand sites in 2026; `aria-expanded` on toggle controls is explicitly called out in the WAI-ARIA Authoring Practices Guide's disclosure pattern.
**Security/Privacy Impact:** None.
**Rollout Readiness:** High.
**Validation Gates:** (1) CI accessibility check runs against the homepage and passes/fails against documented criteria; (2) the mobile menu toggle's `aria-expanded` value correctly reflects open/closed state, verified with a screen reader or automated ARIA-state test; (3) the specific gold-on-black (#FFD700 on #0A0A0A) contrast check from `docs/TEST_STRATEGY.md` §2 is included.
**Acceptance Criteria:** (1) An automated accessibility check runs in CI against the homepage; (2) `.menu-toggle` gains `aria-expanded="true"/"false"` toggled by `script.js` alongside its existing `aria-label`; (3) the color-contrast requirement from `docs/TEST_STRATEGY.md` is included in the automated check; (4) `docs/TEST_STRATEGY.md` §2 is updated to reflect implementation.

### FR-006

**Description:** Add a site-wide broken-link checker (`linkinator` or equivalent) run against the live `https://aresmaxs.com` domain covering all 5 social links and internal pages, per `docs/TEST_STRATEGY.md` §6's explicit command and requirement.
**Why It Matters:** No CI job checks that the 5 outbound social links (X, Instagram, Facebook, YouTube, GitHub) or the 3 legal pages remain live and correctly resolve; a broken social link on a brand site directly undermines the credibility the site exists to project.
**Verification Evidence:** `docs/TEST_STRATEGY.md` lines 66-72 specify the exact `linkinator` command and scope; no such check exists in any of the 3 discovered workflows (EV-01).
**Evidence IDs:** EV-01
**Priority:** P2
**Category:** Web Quality / Brand Integrity
**ROI Score:** 4/10 — moderate value (protects brand credibility), low implementation cost given the command is already documented.
**Risk Score:** 2/10 — trivial complexity.
**Dependencies:** None.
**Competitive Reference:** Standard for brand sites with multiple outbound social links.
**Security/Privacy Impact:** None directly.
**Rollout Readiness:** High.
**Validation Gates:** (1) CI job runs against the live domain with `--recurse`; (2) a deliberately broken link (temporary test) causes the job to flag/fail; (3) all 5 social links and 3 legal pages are confirmed in scope.
**Acceptance Criteria:** (1) A new CI job runs the documented `linkinator` command against the live site; (2) all social and legal-page links are verified; (3) `docs/TEST_STRATEGY.md` §6 is updated to reflect the now-automated process.

### FR-007

**Description:** Add a `.pre-commit-config.yaml` running the markdownlint/frontmatter validation locally before commit, matching the exact gap already identified as unresolved in the sibling `aresmax-blog` repo's `findings.json` F-0005 pattern (no equivalent open finding exists in this repo's own `findings.json`, but the underlying tooling gap is identical).
**Why It Matters:** As with the sibling blog repo, markdown/frontmatter drift only surfaces at PR time via `doc-lint.yml`, after work is already complete — this repo's own `findings.json` F-0002 shows exactly this class of drift already occurred once (10 of 11 doc files failed frontmatter validation) before being fixed.
**Verification Evidence:** Glob for `.pre-commit-config.yaml` at repo root returned no matches (EV-07); `findings.json` F-0002 documents a prior instance of the exact drift class this would prevent.
**Evidence IDs:** EV-07
**Priority:** P2
**Category:** Developer Velocity / CI Hygiene
**ROI Score:** 3/10 — small effort, reduces PR friction for future doc contributions.
**Risk Score:** 2/10 — trivial complexity.
**Dependencies:** Reuses the validation logic already embedded in `.github/workflows/doc-lint.yml`.
**Competitive Reference:** Standard practice; directly mirrors the identical, already-identified gap in the sibling `aresmax-blog` repo.
**Security/Privacy Impact:** None.
**Rollout Readiness:** High.
**Validation Gates:** (1) Committing invalid frontmatter is blocked locally before reaching CI; (2) `pre-commit run --all-files` passes on current repo state; (3) hook logic matches `doc-lint.yml`'s validator exactly.
**Acceptance Criteria:** (1) `.pre-commit-config.yaml` exists with markdownlint-cli2 and frontmatter-validation hooks; (2) `CONTRIBUTING.md` documents installation; (3) the same drift class as `findings.json` F-0002 is prevented from recurring.

### FR-008

**Description:** Add a `LICENSE` file at the repo root declaring reuse terms for this public-facing brand site's code and content.
**Why It Matters:** The repository is publicly hosted with a live custom domain but carries no license file, leaving reuse terms ambiguous for any third party encountering the public repo.
**Verification Evidence:** Glob for `LICENSE*` at repo root returned no matches (EV-05).
**Evidence IDs:** EV-05
**Priority:** P2
**Category:** Governance / Legal Hygiene
**ROI Score:** 3/10 — low direct business impact, near-zero-cost fix.
**Risk Score:** 2/10 — trivial.
**Dependencies:** None.
**Competitive Reference:** Standard GitHub repo hygiene for public repos.
**Security/Privacy Impact:** None.
**Rollout Readiness:** High.
**Validation Gates:** (1) `LICENSE` file exists and is recognized by GitHub's license detector; (2) repo UI displays the detected license.
**Acceptance Criteria:** (1) `LICENSE` file added at repo root; (2) content reflects the intended reuse terms (or explicit all-rights-reserved notice); (3) referenced from `README.md`.

## Prioritized Implementation Roadmap

1. **P0 — Foundation (do first):** FR-001 (fix broken OG image), FR-002 (fix broken Schema.org logo), FR-003 (Lighthouse CI gate). These close two actively-broken, user-visible marketing defects and the entirely-undelivered primary quality gate the repo's own strategy doc promises.
2. **P1 — Quality and Hardening Completion:** FR-004 (remove unused CSP entry — closes an already-logged internal finding), FR-005 (accessibility audit + ARIA fix), FR-006 (link checking).
3. **P2 — Hygiene:** FR-007 (pre-commit hooks), FR-008 (LICENSE).

## Top 5 Highest-ROI Features

| Rank | FR | ROI | Risk | Rationale |
|---|---|---|---|---|
| 1 | FR-001 (Fix broken OG image) | 7 | 3 | Fixes an actively broken social-share preview on a live production brand domain; trivial cost. |
| 2 | FR-003 (Lighthouse CI gate) | 7 | 3 | Closes the entirely-undelivered primary quality gate the repo's own docs promise; command already written. |
| 3 | FR-002 (Fix broken Schema.org logo) | 6 | 3 | Restores rich-result SEO eligibility; trivial cost, same asset-sourcing effort as FR-001. |
| 4 | FR-005 (Accessibility audit + ARIA fix) | 5 | 3 | Closes a documented test category and a concrete WCAG gap cheaply. |
| 5 | FR-004 (Remove unused CSP entry) | 4 | 3 | Closes the repo's own previously-logged, still-open internal finding at zero cost. |

## Validation Plan

- FR-001 and FR-002 should be validated using the exact external tools `docs/TEST_STRATEGY.md` already names (Facebook Sharing Debugger, Twitter Card Validator, Google Rich Results Test) — no new tooling decision is needed.
- FR-003/FR-005/FR-006's CI additions should each demonstrate a passing run against current site state plus a deliberately-broken test case showing correct failure, consistent with the rigor already modeled by this repo's `doc-lint.yml` frontmatter validator.
- FR-004 should follow the exact verification steps already prescribed in the repo's own `findings.json` F-0005 (DevTools CSP-violation check, Lighthouse score parity, cross-browser test).
- After implementation, `docs/TEST_STRATEGY.md` and `docs/SECURITY.md`'s Hardening Backlog should be updated to reflect newly-automated/closed items, keeping the repo's existing self-audit trail current.

## Executive Summary

Aresmaxs.com is a small, well-documented brand landing page with genuinely good SEO/structured-data intent and an active internal self-audit process (`findings.json`) that has already fixed several issues. The verified gaps found in this review split into two categories: two concrete, currently-live marketing defects (a broken Open Graph image and a broken Schema.org logo reference — both referencing files absent from the repo, meaning every social share of this domain shows a broken preview), and the same structural pattern found in the sibling `aresmax-blog` repo, where a thorough test strategy is fully specified in documentation but never wired into the 3 actual CI workflows, all of which govern documentation and AI-agent metadata rather than the shipped site. One additional finding (unused CSP script-source whitelist entry) is not new — it corroborates and elevates a finding the repo's own prior audit already logged and left unresolved. The highest-priority items (FR-001, FR-002, FR-003) should be treated as immediate fixes given their direct, active impact on brand presentation for a live production domain.
