ARG BASE_IMAGE=genesiscommunity/concourse:ubuntu-noble
FROM --platform=linux/amd64 $BASE_IMAGE
ARG SBCL_VERSION

WORKDIR /tmp
RUN curl -L -o sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 \
    https://github.com/roswell/sbcl_bin/releases/download/${SBCL_VERSION}/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 && \
    tar xjf sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 && \
    cd sbcl-${SBCL_VERSION}-x86-64-linux && \
    INSTALL_ROOT=/usr/local sh install.sh && \
    cd /tmp && \
    rm -rf sbcl-${SBCL_VERSION}-x86-64-linux*

ARG BUILD_DATE
ARG VCS_URL=https://github.com/genesis-community/concourse-dockerfiles
ARG VCS_REF
LABEL org.opencontainers.image.authors="Norman Abramovitz, James Hunt" \
      org.opencontainers.image.title="Common Lisp Build Container" \
      org.opencontainers.image.version="" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.source=$VCS_URL \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.base.name=$BASE_IMAGE

CMD ["sbcl", "--script", "/u/boot.lisp"]
