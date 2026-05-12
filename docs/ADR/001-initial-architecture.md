---
title: "ADR-001: Initial Architecture — Static HTML/CSS/JS on GitHub Pages"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---

# ADR-001: Initial Architecture — Static HTML/CSS/JS on GitHub Pages

**Date:** 2026-02-01
**Status:** Accepted
**Author:** migar

---

## Context

Aresmaxs.com is the flagship brand home for Aresmax Digital — a cinematic, high-production brand experience intended to signal premium quality and serious technical capability. The site showcases products/services, communicates revenue streams, and drives traffic to anavr.in for purchases.

The primary requirements are: maximum visual impact, exceptional performance (sub-2s load), and zero operational overhead.

Architecture options evaluated:

1. **Static HTML/CSS/JS on GitHub Pages** — full creative control, zero cost, CDN-backed
2. **Next.js on Vercel** — React-based, SSR capable, but adds bundle weight and build complexity
3. **Webflow** — designer-friendly, but limits custom animation control; $23+/month
4. **Framer** — motion-first design tool, but proprietary and creates vendor lock-in

## Decision

**Pure static HTML/CSS/JS hosted on GitHub Pages.**

All animations are CSS-only (keyframes, transitions). Interactive elements use vanilla JavaScript with IntersectionObserver. No npm, no build pipeline, no JavaScript framework.

## Rationale

### Why CSS-only animations (not GSAP/Three.js)?

- The brand positioning requires a fast, cinematic experience. Heavy JavaScript animation libraries (GSAP, Three.js) add 100–300KB of JavaScript that delays first meaningful paint.
- CSS keyframe animations are hardware-accelerated by the browser's compositor thread — they do not block the main thread and achieve consistent 60fps.
- No dependency management, no security vulnerabilities from third-party animation libraries.

### Why static HTML (not React/Next.js)?

- A brand landing page is content that changes infrequently. The complexity of a React component tree, virtual DOM, and hydration cycle provides zero value for this use case.
- Pure HTML/CSS loads faster, scores higher on Lighthouse by default, and is simpler to maintain.

### Why GitHub Pages (not Vercel/Netlify)?

- GitHub is already the VCS host — Pages adds zero friction
- Custom domain (aresmaxs.com) with automatic HTTPS via Let's Encrypt
- Fastly CDN provides adequate global performance
- Free for public repositories

### Design Inspiration and Differentiation

The "no heavy JS libraries" constraint forces creative solutions in CSS — gradient animations, `background-clip: text`, IntersectionObserver reveals — that achieve award-site aesthetics without the bundle cost. This is aligned with the brand's "bold, unapologetic, tech-forward" voice.

## Consequences

### Positive
- Sub-1s First Contentful Paint achievable
- High Lighthouse scores (Performance, SEO) by default
- Deployment is a single `git push`
- No security patching for dependencies
- Full pixel-level design control

### Negative / Trade-offs
- No dynamic content or personalization
- A/B testing requires client-side tools (Google Optimize) rather than server-side splits
- All content updates require editing raw HTML

## Future Considerations

If the site evolves to require server-side personalization, dynamic product catalogs, or user authentication, the migration path is to Next.js on Vercel. Current HTML sections can be converted to React components incrementally. The CSS design system (custom properties, keyframes) is fully portable to any framework.
