---
title: "Security"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---

# Security — aresmaxs.com

## Content Security Policy

CSP is enforced via `<meta http-equiv="Content-Security-Policy">` in `index.html`.

Current policy (as in `index.html`):

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

Rationale:
- `'unsafe-inline'` on `script-src` accommodates the inline `<script type="application/ld+json">` Schema.org block (Schema.org JSON-LD is data, not executed code, but CSP still gates the tag).
- `'unsafe-inline'` on `style-src` accommodates animation-related inline styles.
- `cdnjs.cloudflare.com` is whitelisted but not currently consumed — candidate for removal (see Hardening Backlog).
- `img-src 'self' data: https:` is broader than needed; tightenable once asset audit is complete.

### Hardening Backlog

| Item | Action | Risk if deferred |
|---|---|---|
| Drop `https://cdnjs.cloudflare.com` from `script-src` (unused) | One-line edit + Lighthouse verification | Allows a future inline-script bug to load arbitrary cdnjs payloads |
| Replace `'unsafe-inline'` on `script-src` with SHA-256 hash of JSON-LD block | Compute hash, swap directive, test on Chrome/Firefox/Safari | Inline-script XSS surface remains open |
| Narrow `img-src` to specific allowed hosts | Audit referenced images, allowlist hosts | Hotlinking and tracking-pixel risk |

## Secrets and Environment Variables

This is a static site. There are no server-side secrets. Do not embed:
- API keys in HTML/JS
- Tracking pixels that leak referrer data without disclosure
- Third-party scripts without subresource integrity (SRI) hashes

## Dependency Security

No npm dependencies in production. `npx serve` (dev only) should be used with a lockfile.

## Reporting Vulnerabilities

Email security issues to the repo owner. Do not open public GitHub issues for security bugs.

## Privacy Pages

- `privacy.html` — data collection disclosure
- `terms.html` — terms of service
- `refund.html` — refund policy

Keep these pages current with any new data processing activities.
