---
title: "Architecture"
owner: "migar"
status: "Active"
last_reviewed: "2026-05-12"
---

# Architecture — aresmaxs.com

## Overview

Aresmax brand landing page

**Group:** Content & Marketing
**Portfolio:** ClawMedia Digital Suite

## 3-Tier Design

### Backend Tier
- **Framework:** None
- **Port:** N/A
- **API prefix:** `/api/v1/`
- **OpenAPI docs:** `http://localhost:N/A/docs`

### Application Tier
- (API-only or library — no service tier)

### Frontend Tier
- **Type:** Static HTML
- **Path:** N/A

## Connectors & Integrations

- None defined

## Portfolio Connections

- **Command center:** `claude` (port 5556) — orchestrates tasks to this repo
- **Analytics:** `dev-analytics/` — receives CI/CD results
- **Shared brain:** `arescore` (port 8889) — shared KPIs and memory
- **Agent gateway:** `openclaw` — skill routing and automation

## Data Storage

- (describe databases, files, caches used)

## Security

- Auth: Bearer token / JWT (portfolio standard)
- Secrets: `.env` only, never committed
- Protected paths: see `AGENT.md → authority.protected_paths`

*Generated: 2026-03-29*
