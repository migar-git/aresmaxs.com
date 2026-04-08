# Runbook — aresmaxs.com

## Service Overview

- **Site:** https://aresmaxs.com
- **Type:** Static HTML/CSS/JS brand landing page
- **Hosting:** GitHub Pages (branch: main)
- **Custom Domain:** aresmaxs.com

---

## Routine Operations

### Deploy a Change

```bash
git add <files>
git commit -m "type: description"
git push origin main
```

GitHub Pages publishes within ~60 seconds.

### Verify the Site is Live

```bash
curl -I https://aresmaxs.com
# Expect: HTTP/2 200
```

---

## Incident Procedures

### Site Not Loading

1. Check https://www.githubstatus.com
2. If GitHub Pages operational: check Settings → Pages, confirm source is `main` / root
3. Check last commit did not break HTML structure (mismatched tags, etc.)

### Domain Not Resolving

1. Verify DNS:
   ```bash
   dig aresmaxs.com A +short
   # Expected: 185.199.108–111.153
   ```
2. Verify A records at registrar
3. Allow up to 48 hours for DNS changes to propagate
4. Verify CNAME file in repo root contains `aresmaxs.com`

### HTTPS Certificate Issue

1. Repository Settings → Pages → verify "Enforce HTTPS" enabled
2. Toggle off/on to re-trigger Let's Encrypt certificate provisioning
3. Certificate provisioning can take up to 24 hours after DNS is resolved

### CSS Animations Not Playing

1. Check browser console for CSS errors
2. Verify `style.css` was correctly pushed (check file size vs. last known good)
3. Clear browser cache and reload
4. If animations are missing for all users, roll back the last style.css commit

### Rollback a Bad Deployment

```bash
git revert HEAD
git push origin main
# Or for a specific commit:
git revert <bad-commit-sha>
git push origin main
```

---

## Cache Invalidation

- GitHub Pages CDN caches assets. After a push, allow 60–120 seconds.
- Test with incognito browser window or hard-refresh (Ctrl+Shift+R)
- For CSS/JS changes, append a cache-buster query string in the HTML during testing: `style.css?v=2`

---

## Content Operations

### Update Social Links

Search `index.html` for the social platform URL and update. Push to main.

### Update Revenue Counter Values

Locate the counter section in `index.html` (data attributes on counter elements). Update values and push.

### Add a New Section

1. Add the HTML section to `index.html`
2. Add corresponding styles to `style.css`
3. If the section uses IntersectionObserver animations, add the trigger class in `script.js`
4. Test at 375px, 768px, 1280px before pushing

---

## Monitoring

- Recommended: UptimeRobot free monitor on https://aresmaxs.com
- Check Google Search Console monthly for crawl errors and Core Web Vitals

---

## Contacts

| Role | Contact |
|---|---|
| Site Owner | migar (GitHub) |
| Domain Registrar | Check registrar account for aresmaxs.com |
