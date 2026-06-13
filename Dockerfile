# See Dockerfile.build for instructions on bumping this.
FROM ghcr.io/py-cov-action/python-coverage-comment-action-base@sha256:4e402f0ca04cadcd7cd916e0e8145437cafeba81defbc39308366515b834d316 # v6

COPY coverage_comment ./coverage_comment
RUN md5sum -c pyproject.toml.md5 || pip install -e .
