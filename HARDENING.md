<!-- markdownlint-disable -->

# Hardening Report: py-cov-action--python-coverage-comment-action/v3.38

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **py-cov-action--python-coverage-comment-action/v3.38** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The action uses `runs.using: docker` with `image: Dockerfile`, and that Dockerfile references a mutable image tag `ghcr.io/py-cov-action/python-coverage-comment-action-base:v6` instead of a SHA digest. A mutable tag can be silently updated to point to a different (potentially malicious) image, creating a supply-chain risk equivalent to an unpinned `uses:` reference. It should be pinned to a SHA digest, e.g. `ghcr.io/py-cov-action/python-coverage-comment-action-base@sha256:<64-hex-char-digest> # v6`.

Locations:

- `Dockerfile:2`
- `action.yml:163`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the Dockerfile base image from the mutable tag `ghcr.io/py-cov-action/python-coverage-comment-action-base:v6` to the immutable digest `ghcr.io/py-cov-action/python-coverage-comment-action-base@sha256:4e402f0ca04cadcd7cd916e0e8145437cafeba81defbc39308366515b834d316 # v6`. The action.yml uses `image: Dockerfile` (a local reference) so no change was needed there.

