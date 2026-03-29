# Agent Readiness — aresmaxs.com

**Audit Date:** 2026-03-29

## Current Agent Readiness: Low (18 / 100)

The monolithic structure makes agent-driven content updates risky — editing a 68KB HTML file programmatically is error-prone. Until refactored, agent automation is not recommended for this site.

## What's Working

- AGENT.md schema v1.0 present.
- Git-based deployment to GitHub Pages means an agent can publish by pushing.

## What Needs to Be Built for Agent Automation

| Component | Priority | Description |
|-----------|----------|-------------|
| CSS/JS refactor | Critical | Prerequisite for safe agent edits |
| `update_homepage.py` | High | Agent script to update specific sections (hero text, product prices) without touching full HTML |
| `sitemap.xml` generator | High | Agent regenerates after adding new pages |
| GitHub Actions workflow | High | Validates HTML and deploys on push |
| Analytics API reader | Medium | Agent reads performance data for arescore KPIs |
| A/B test framework | Low | Agent can test different headline variations |

## For Static Site Agents — Recommended Approach

Until the CSS/JS refactor is complete, agents should only update `index.html` via well-defined string replacements (e.g., replace a specific `<title>` or meta description), never full-file rewrites.

After refactor:
1. Agent can safely edit `css/style.css` for design updates.
2. Agent can update specific `<section>` blocks in `index.html` using DOM manipulation (via Python + BeautifulSoup).
3. Agent can add new pages by copying from a template.
4. Full content pipeline integration with arescore becomes feasible.
