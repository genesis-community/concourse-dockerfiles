ARG BASE_IMAGE=genesiscommunity/concourse:ubuntu-jammy
FROM --platform=linux/amd64 $BASE_IMAGE
ARG SF_SBCL_VERSION

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends sbcl && \
#     rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://sourceforge.net/projects/sbcl/files/sbcl/${SF_SBCL_VERSION}/sbcl-${SF_SBCL_VERSION}-x86-64-linux-binary.tar.bz2/download -O sbcl-${SF_SBCL_VERSION}-x86-64-linux-binary.tar.bz2 && \
tar xjf sbcl-${SF_SBCL_VERSION}-x86-64-linux-binary.tar.bz2
WORKDIR sbcl-${SF_SBCL_VERSION}-x86-64-linux
RUN INSTALL=/usr/local sh install.sh
WORKDIR /tmp
RUN rm -rf sbcl-${SF_SBCL_VERSION}-x86-64-linux*

ARG BUILD_DATE
ARG VCS_URL=https://github.com/genesis-community/concourse-dockerfiles
ARG VCS_REF
LABEL org.opencontainers.image.authors="Norman Abramovitz, James Hunt" \
      org.opencontainers.image.title="Common List Build Container" \
      org.opencontainers.image.version="" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.source=$VCS_URL \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.base.name=$BASE_IMAGE

CMD ["sbcl", "--script", "/u/boot.lisp"]
