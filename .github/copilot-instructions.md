# Copilot Instructions — aresmaxs.com

## Repository Context
This is part of the migar-git organization. Read CLAUDE.md and AGENTS.md for full context.

## Code Standards
- Python: black (88 chars), ruff, mypy strict, pytest
- No file > 200 lines of logic
- All public functions need docstrings (Args/Returns/Raises/Example)
- No secrets in code — use environment variables
- No shell=True in subprocess calls
- Parameterized SQL only (no f-string interpolation)

## Security Rules
- All API endpoints MUST have authentication
- No hardcoded credentials — fail-closed on missing env vars
- SSRF: validate all URLs including redirect targets
- Run `gitleaks detect --no-git` before committing

## Testing
- pytest with conftest.py fixtures
- Mock external APIs
- Target ≥80% coverage on new code
