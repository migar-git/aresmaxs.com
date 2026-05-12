---
title: "Test Strategy"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---

# Test Strategy — aresmaxs.com

## Overview

Aresmaxs.com is a static HTML/CSS/JS brand landing page with no backend or build pipeline. Testing focuses on frontend performance, accessibility, animation quality, and SEO.

## Test Categories

### 1. Lighthouse Audits (Primary Quality Gate)

**Targets:**

| Category | Minimum Score |
|---|---|
| Performance | ≥ 90 |
| Accessibility | ≥ 90 |
| Best Practices | ≥ 90 |
| SEO | ≥ 95 |

```bash
npx lighthouse https://aresmaxs.com --output html --output-path ./lighthouse-report.html
```

Run on both desktop and mobile presets. The site's CSS animations must not cause Lighthouse performance regressions (verify CLS score is low).

### 2. Accessibility Testing

- Run axe DevTools on the homepage
- All images require descriptive `alt` text
- Verify `prefers-reduced-motion` CSS query disables animations for users who opt out
- Keyboard navigation must reach all interactive elements (nav links, CTA buttons, social links)
- Color contrast: gold (#FFD700) on black (#0A0A0A) must meet 4.5:1 ratio

### 3. Animation and Performance Testing

- Verify CSS keyframe animations play at 60fps (use Chrome DevTools Performance tab)
- Confirm no layout shift from animated hero section (CLS < 0.1)
- IntersectionObserver scroll reveals must trigger correctly on first scroll
- Custom cursor must initialize without errors on desktop

### 4. Cross-Browser Testing

Chrome, Firefox, Safari, Edge — latest versions.

Focus: CSS custom properties, `background-clip: text` gradient effects, IntersectionObserver, animated counters.

### 5. Mobile/Responsive Testing

| Breakpoint | Device |
|---|---|
| 375px | iPhone SE |
| 390px | iPhone 14 |
| 768px | iPad portrait |
| 1280px | Desktop |
| 1920px | Large desktop |

Priority: hamburger menu must function at all mobile widths; hero headline must not overflow at 375px.

### 6. Link Checking

```bash
npx linkinator https://aresmaxs.com --recurse
```

Verify all social links (X, Instagram, Facebook, YouTube, GitHub) and product CTAs are functional.

### 7. SEO Checks

- Schema.org Organization markup valid (test at https://search.google.com/test/rich-results)
- Open Graph tags correct for social sharing
- `<title>` and `<meta name="description">` present
- sitemap.xml lists the domain

### 8. Visual Regression (Major Redesigns)

```bash
npx playwright screenshot https://aresmaxs.com --full-page --output before.png
# Make changes
npx playwright screenshot https://aresmaxs.com --full-page --output after.png
```

## Test Schedule

| Trigger | Tests |
|---|---|
| Before every push | Browser smoke test, confirm animations |
| New section added | Mobile layout, accessibility, link check |
| Major redesign | Full Lighthouse, cross-browser, visual regression |
| Monthly | Lighthouse audit, link check |
