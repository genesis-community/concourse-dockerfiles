genesiscommunity/concourse-cl:ubuntu-jammy
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
       genesiscommunity/concourse-cl:ubuntu-jammy
```

By default the image executes `/u/boot.lisp`.

## Building

From the repository root:

```bash
# Build the base image and CL image
make cl-jammy

# Build with a specific SBCL version
make cl-jammy SBCL_VERSION=2.6.2

# Switch SBCL distribution source (roswell or sourceforge)
make cl-jammy SBCL_DIST=sourceforge

# Override platform (default: linux/amd64)
make cl-jammy PLATFORM=linux/arm64
```

Or build from the `concourse-cl/jammy/` directory:

```bash
cd concourse-cl/jammy
make docker                          # build the image
make test                            # run hello-world test
make publish                         # push to Docker Hub
```

## Using as a Base Image

Example Dockerfile for building a Common Lisp project:

```dockerfile
FROM genesiscommunity/concourse-cl:ubuntu-jammy
WORKDIR /app
COPY . .
RUN sbcl --non-interactive \
         --eval '(push (truename ".") asdf:*central-registry*)' \
         --eval '(ql:quickload :my-system)' \
         --eval '(sb-ext:save-lisp-and-die "my-app" :executable t :toplevel #'\''my-package:main)'
CMD ["/app/my-app"]
```

## Compatibility Notes

The Roswell SBCL binary is built for broad Linux compatibility. It only
requires **GLIBC 2.17** or newer, making it safe to run on any modern
Linux distribution.

Libraries loaded at runtime via CFFI (such as OpenSSL via cl+ssl) use
`dlopen` and resolve against the shared libraries inside the container.
Since each image is self-contained, there are no cross-distribution
glibc or library version issues.

**Important:** A binary compiled with `save-lisp-and-die` inside one
image (e.g. noble with glibc 2.39) should not be extracted and run on
an older host (e.g. jammy with glibc 2.35). Always run the binary in
the same container environment it was built in.

| Image | Ubuntu | glibc | OpenSSL |
|-------|--------|-------|---------|
| ubuntu-jammy | 22.04 LTS | 2.35 | 3.0.2 |
| ubuntu-noble | 24.04 LTS | 2.39 | 3.0.13 |

## Makefile Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SBCL_VERSION` | `2.6.2` | SBCL version to install |
| `SBCL_DIST` | `roswell` | Download source (`roswell` or `sourceforge`) |
| `PLATFORM` | `linux/amd64` | Docker build platform |
