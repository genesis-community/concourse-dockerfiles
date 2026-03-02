ARG BASE_IMAGE=genesiscommunity/concourse:ubuntu-noble
FROM --platform=linux/amd64 $BASE_IMAGE
ARG SBCL_VERSION
ARG SBCL_DIST=roswell

WORKDIR /tmp
RUN case "${SBCL_DIST}" in \
      roswell)     url="https://github.com/roswell/sbcl_bin/releases/download/${SBCL_VERSION}/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2" ;; \
      sourceforge) url="https://sourceforge.net/projects/sbcl/files/sbcl/${SBCL_VERSION}/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2/download" ;; \
      *)           echo "Unknown SBCL_DIST: ${SBCL_DIST}" >&2 && exit 1 ;; \
    esac && \
    curl -L -o sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 "$url" && \
    tar xjf sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 && \
    cd sbcl-${SBCL_VERSION}-x86-64-linux && \
    INSTALL_ROOT=/usr/local sh install.sh && \
    cd /tmp && \
    rm -rf sbcl-${SBCL_VERSION}-x86-64-linux*

# Install Quicklisp
RUN curl -L -o /tmp/quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --non-interactive \
         --load /tmp/quicklisp.lisp \
         --eval '(quicklisp-quickstart:install)' \
         --eval '(ql-util:without-prompting (ql:add-to-init-file))' && \
    rm /tmp/quicklisp.lisp

ARG BUILD_DATE
ARG VCS_URL=https://github.com/genesis-community/concourse-dockerfiles
ARG VCS_REF
LABEL org.opencontainers.image.authors="Norman Abramovitz, James Hunt" \
      org.opencontainers.image.title="Common Lisp Build Container" \
      org.opencontainers.image.version=$SBCL_VERSION \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.source=$VCS_URL \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.base.name=$BASE_IMAGE

WORKDIR /u
CMD ["sbcl", "--script", "/u/boot.lisp"]
