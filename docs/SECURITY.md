# Security — aresmaxs.com

## Content Security Policy

CSP is enforced via `<meta http-equiv="Content-Security-Policy">` in `index.html`.

Current policy goals:
- `default-src 'self'` — no third-party script execution
- `style-src 'self' 'unsafe-inline'` — inline styles permitted (animations)
- `script-src 'self'` — no inline scripts; all JS in `script.js`
- `img-src 'self' data:` — no external image hotlinking

Review and tighten this policy before adding any third-party embeds or analytics.

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
