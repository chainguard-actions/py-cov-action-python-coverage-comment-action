<!-- markdownlint-disable -->

# Hardening Report: py-cov-action--python-coverage-comment-action/v4.3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **py-cov-action--python-coverage-comment-action/v4.3** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Two workflow steps use `py-cov-action/python-coverage-comment-action@main`, which pins to a mutable branch ref (`main`) rather than an immutable 40-character commit SHA. If the `main` branch is compromised or force-pushed, the action will silently execute attacker-controlled code. The comments acknowledge this as intentional dogfooding (`# zizmor: ignore[unpinned-uses] Dogfooding`), but it still represents a supply-chain risk.

Locations:

- `.github/workflows/ci.yml:46`
- `.github/workflows/coverage-comment.yml:28`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned both `py-cov-action/python-coverage-comment-action@main` references to the resolved commit SHA `a05be3d2e8a6272d3ef5fb2840ab20368bb2eb71` in `.github/workflows/ci.yml` (line 46) and `.github/workflows/coverage-comment.yml` (line 28). The mutable `main` branch ref is now replaced with an immutable 40-character SHA, eliminating the supply-chain risk. The `# zizmor: ignore[unpinned-uses] Dogfooding` comments were removed since the references are now properly pinned.

