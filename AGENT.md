---
schema_version: "1.0"
---

# Agent Manifest: aresmaxs.com

```yaml
repo: aresmaxs.com
type: static-site
description: "Minimal static site — Aresmax brand landing page (CNAME + index.html)"
owner: migar-git
```

## Authority

```yaml
authority:
  max_auto_level: 1
  always_open_pr: true
  protected_paths:
    - .env*
  notify_on: [2, 3]
  allowed_machines: []
```

## Commands

```yaml
commands:
  test:   ""
  lint:   ""
  format: ""
  build:  ""
  deploy: ""
```

## LLM Routing

```yaml
llm:
  local_model: "qwen2.5-coder:7b"
  escalate_on:
    - cross_repo_change
    - architecture_decision
    - security_related
    - confidence_below: 0.75
```

## Dependencies

```yaml
dependencies: []
```

## CI / Analytics

```yaml
ci:
  push_results: false
  min_pass_rate: 1.0
  track:
    - lint_errors
```

## Notes

```yaml
notes: |
  - Minimal static site — CNAME record + single index.html
  - GitHub Pages hosted (CNAME file present)
  - Aresmax brand landing page
```
