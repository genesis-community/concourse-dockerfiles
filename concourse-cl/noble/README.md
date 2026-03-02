genesiscommunity/concourse-cl:ubuntu-noble
===========================================

Task Image for running Concourse Pipelines - Common Lisp

This Docker image contains a set of utilities commonly used in
Concourse pipelines, pre-installed, along with:

- **SBCL** (Steel Bank Common Lisp) via Roswell binary releases
- **Quicklisp** package manager (auto-loaded on startup)
- **ASDF** build system

## Included Software

| Component | Version | Source |
|-----------|---------|--------|
| SBCL      | 2.6.2   | Roswell |
| Quicklisp | latest  | beta.quicklisp.org |
| ASDF      | 3.3.1   | bundled with SBCL |

## Quick Start

Run a Lisp script:

```bash
docker run -it \
       -v ~/code/my-lisp-code-directory:/u \
       genesiscommunity/concourse-cl:ubuntu-noble
```

By default the image executes `/u/boot.lisp`.

## Building

From the repository root:

```bash
# Build the base image and CL image
make cl-noble

# Build with a specific SBCL version
make cl-noble SBCL_VERSION=2.6.2

# Switch SBCL distribution source (roswell or sourceforge)
make cl-noble SBCL_DIST=sourceforge

# Override platform (default: linux/amd64)
make cl-noble PLATFORM=linux/arm64
```

Or build from the `concourse-cl/noble/` directory:

```bash
cd concourse-cl/noble
make docker                          # build the image
make test                            # run hello-world test
make publish                         # push to Docker Hub
```

## Using as a Base Image

Example Dockerfile for building a Common Lisp project:

```dockerfile
FROM genesiscommunity/concourse-cl:ubuntu-noble
WORKDIR /app
COPY . .
RUN sbcl --non-interactive \
         --eval '(push (truename ".") asdf:*central-registry*)' \
         --eval '(ql:quickload :my-system)' \
         --eval '(sb-ext:save-lisp-and-die "my-app" :executable t :toplevel #'\''my-package:main)'
CMD ["/app/my-app"]
```

## Makefile Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SBCL_VERSION` | `2.6.2` | SBCL version to install |
| `SBCL_DIST` | `roswell` | Download source (`roswell` or `sourceforge`) |
| `PLATFORM` | `linux/amd64` | Docker build platform |
