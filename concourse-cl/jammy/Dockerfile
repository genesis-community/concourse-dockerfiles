
ARG BASE_IMAGE=genesiscommunity/concourse:ubuntu-jammy
FROM --platform=linux/amd64 $BASE_IMAGE

RUN apt-get update && \
    apt-get install -y --no-install-recommends sbcl && \
    rm -rf /var/lib/apt/lists/*

CMD ["sbcl", "--script", "/u/boot.lisp"]
