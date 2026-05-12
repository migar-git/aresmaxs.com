---
title: "Deployment"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---

# Deployment — aresmaxs.com

## Platform

Hosted on **GitHub Pages** (`master` branch → root). Custom domain set via `CNAME` file.

## Deploy Process

```
git add .
git commit -m "your message"
git push origin master
```

GitHub Pages rebuilds automatically within ~30 seconds. No CI pipeline required.

## Custom Domain

- CNAME file contains `aresmaxs.com`
- DNS A records point to GitHub Pages IPs (185.199.108–111.153)
- HTTPS is enforced via GitHub Pages TLS

## Rollback

```bash
git revert HEAD
git push origin master
```

Or use the GitHub UI: Settings → Pages → revert via commit history.

## Environment Variables

None — this is a fully static site. No server-side secrets required.

## Checklist Before Pushing

- [ ] HTML validates (no broken tags)
- [ ] No hardcoded localhost URLs
- [ ] sitemap.xml updated if pages added/removed
- [ ] robots.txt reflects correct domain
