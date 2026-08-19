<!-- markdownlint-disable -->

# Hardening Report: py-cov-action--python-coverage-comment-action/v3.41

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **py-cov-action--python-coverage-comment-action/v3.41** was hardened automatically. 4 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Every `uses:` reference across all workflow files uses a mutable tag or branch ref instead of a pinned 40-character commit SHA, making the action vulnerable to supply-chain attacks. Failing references include: ci.yml: actions/checkout@v6, astral-sh/setup-uv@v7, py-cov-action/python-coverage-comment-action@main, actions/upload-artifact@v6; coverage-comment.yml: py-cov-action/python-coverage-comment-action@main; e2e-external-phase-1.yml: actions/upload-artifact@v6; e2e-external-phase-2.yml: actions/checkout@v6, astral-sh/setup-uv@v7, actions/cache@v5; manual-release.yml: actions/checkout@v6; release.yml: actions/checkout@v6, docker/setup-buildx-action@v3, docker/login-action@v3, docker/setup-qemu-action@v3.6.0, docker/setup-buildx-action@v3.11.1, docker/login-action@v3.6.0, docker/metadata-action@v5.8.0, docker/build-push-action@v6.

Locations:

- `.github/workflows/ci.yml:16`
- `.github/workflows/ci.yml:19`
- `.github/workflows/ci.yml:30`
- `.github/workflows/ci.yml:33`
- `.github/workflows/ci.yml:44`
- `.github/workflows/ci.yml:50`
- `.github/workflows/coverage-comment.yml:17`
- `.github/workflows/e2e-external-phase-1.yml:23`
- `.github/workflows/e2e-external-phase-2.yml:72`
- `.github/workflows/e2e-external-phase-2.yml:78`
- `.github/workflows/e2e-external-phase-2.yml:81`
- `.github/workflows/manual-release.yml:16`
- `.github/workflows/release.yml:20`
- `.github/workflows/release.yml:23`
- `.github/workflows/release.yml:26`
- `.github/workflows/release.yml:30`
- `.github/workflows/release.yml:34`
- `.github/workflows/release.yml:38`
- `.github/workflows/release.yml:42`
- `.github/workflows/release.yml:46`
- `.github/workflows/release.yml:76`

### missing-permissions (severity: medium)

Three workflow files have no top-level `permissions:` key and at least one job also lacks a job-level `permissions:` key, so those jobs run with default (potentially broad) GITHUB_TOKEN permissions. (1) e2e-delete-repo.yml: no top-level permissions and the `test` job has no job-level permissions. (2) e2e-external-phase-1.yml: no top-level permissions and the `test` job has no job-level permissions. (3) e2e-private-link-in-pr.yml: no top-level permissions and the `invite` job has no job-level permissions (only the `comment` job has permissions).

Locations:

- `.github/workflows/e2e-delete-repo.yml:1`
- `.github/workflows/e2e-external-phase-1.yml:1`
- `.github/workflows/e2e-private-link-in-pr.yml:1`

### script-injection (severity: high)

Multiple `run:` blocks expand env vars holding workflow-controllable data without double-quoting (sub-rule b). Shell metacharacters in attacker-controlled values could enable command injection. (1) e2e-delete-repo.yml lines 13/19/24: `${NUMBER}` unquoted in `gh repo delete` URL; NUMBER=${{ github.event.pull_request.number }}. (2) e2e-public-link-in-pr.yml line 12: `${LINK}` and `${NUMBER}` unquoted in `gh pr comment ${LINK}`; LINK=${{ github.event.pull_request.html_url }}, NUMBER=${{ github.event.pull_request.number }}. (3) e2e-private-link-in-pr.yml line 30: `${LOGIN}`, `${NUMBER}`, `${PERMISSION}` unquoted in `gh api ... /collaborators/${LOGIN} -f permission=${PERMISSION}`; LOGIN includes ${{ github.event.issue.user.login }}. (4) e2e-private-link-in-pr.yml line 51: `${LINK}` and `${NUMBER}` unquoted in `gh pr comment ${LINK}`; LINK=${{ github.event.issue.html_url }}. (5) e2e-external-phase-2.yml line 115: `-F conclusion=${JOB_STATUS}` unquoted; JOB_STATUS=${{ job.status }}.

Locations:

- `.github/workflows/e2e-delete-repo.yml:13`
- `.github/workflows/e2e-delete-repo.yml:19`
- `.github/workflows/e2e-delete-repo.yml:24`
- `.github/workflows/e2e-public-link-in-pr.yml:12`
- `.github/workflows/e2e-private-link-in-pr.yml:30`
- `.github/workflows/e2e-private-link-in-pr.yml:51`
- `.github/workflows/e2e-external-phase-2.yml:115`

### github-env-injection (severity: high)

In e2e-external-phase-2.yml, the 'Extract PR number from artifact' step pipes the output of `funzip` (decompressed artifact content from an attacker-controlled PR artifact) directly to `${GITHUB_OUTPUT}` without sanitization (`printf '%s' ... | tr -d '\n\r'`). An attacker could craft an artifact containing newline-delimited key=value pairs to inject arbitrary entries into GITHUB_OUTPUT and hijack subsequent steps. Offending pattern: `gh api ... | xargs gh api | funzip > "${GITHUB_OUTPUT}"`

Locations:

- `.github/workflows/e2e-external-phase-2.yml:22`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions, script-injection, github-env-injection

**Notes:**

Fixed all four findings across 8 workflow files:

1. **unpinned-uses**: Pinned all action references to full 40-char SHAs:
   - actions/checkout@v6 → @df4cb1c069e1874edd31b4311f1884172cec0e10
   - astral-sh/setup-uv@v7 → @37802adc94f370d6bfd71619e3f0bf239e1f3b78
   - py-cov-action/python-coverage-comment-action@main → @df46427f7dd5d7798834fed9669de6bfb7a00628
   - actions/upload-artifact@v6 → @b7c566a772e6b6bfb58ed0dc250532a479d7789f
   - actions/cache@v5 → @caa296126883cff596d87d8935842f9db880ef25
   - docker/setup-buildx-action@v3 → @8d2750c68a42422c14e847fe6c8ac0403b4cbd6f
   - docker/login-action@v3 → @c94ce9fb468520275223c153574b00df6fe4bcc9
   - docker/setup-qemu-action@v3.6.0 → @29109295f81e9208d7d86ff1c6c12d2833863392
   - docker/setup-buildx-action@v3.11.1 → @e468171a9de216ec08956ac3ada2f0791b6bd435
   - docker/login-action@v3.6.0 → @5e57cd118135c172c3672efd75eb46360885c0ef
   - docker/metadata-action@v5.8.0 → @c1e51972afc2121e065aed6d45c65596fe445f3f
   - docker/build-push-action@v6 → @10e90e3645eae34f1e60eeb005ba3a3d33f178e8

2. **missing-permissions**: Added `permissions: {}` top-level to e2e-delete-repo.yml, e2e-external-phase-1.yml, e2e-private-link-in-pr.yml; added job-level permissions to `test` job in e2e-delete-repo.yml and `invite` job in e2e-private-link-in-pr.yml.

3. **script-injection**: Quoted all unquoted `${VAR}` expansions in shell commands across e2e-delete-repo.yml, e2e-public-link-in-pr.yml, e2e-private-link-in-pr.yml, and e2e-external-phase-2.yml.

4. **github-env-injection**: Rewrote the 'Extract PR number from artifact' step in e2e-external-phase-2.yml to capture funzip output into a variable, sanitize with `printf '%s' | tr -d '\n\r'`, then write the safe value to GITHUB_OUTPUT.

### Iteration 2

**Fixes applied:** missing-permissions

**Notes:**

Added `permissions: {}` to the `typing` job in `.github/workflows/ci.yml`. The typing job only performs code checkout and type checking, requiring no GitHub token permissions. The `test` job already had its own explicit permissions block and was left unchanged.

