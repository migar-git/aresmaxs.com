# Contributing to aresmaxs.com

## Local Development

Open `index.html` directly in a browser — no build step required.

```bash
# Optional: use a local dev server for accurate MIME types
npx serve .
# or
python -m http.server 8080
```

## Updating Content

- **Copy / brand voice:** Edit `index.html` sections directly.
- **Styles:** All CSS lives in `style.css`. Follow the existing CSS custom property conventions.
- **Scripts:** `script.js` handles animations and cursor logic — keep it dependency-free.

## Deploying

Push to `master`. GitHub Pages auto-deploys via the CNAME record. See `docs/DEPLOYMENT.md`.

## Code Standards

- No external JS frameworks — vanilla JS only.
- Keep CSS animations GPU-friendly (`transform`, `opacity`).
- Run an HTML validator before merging significant markup changes.
- Do not commit secrets, API keys, or `.env` files.
