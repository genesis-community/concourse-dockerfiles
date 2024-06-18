ARG BASE_IMAGE=genesiscommunity/concourse:latest
FROM --platform=linux/amd64 $BASE_IMAGE
# https://github.com/genesiscommunity/dockerfiles/blob/master/concourse/Dockerfile
# Dockerfile go build ref:
# https://github.com/docker-library/golang/blob/5c6fa89055275c8f182ce96af9f5cde8399bdf76/1.20/bullseye/Dockerfile

USER root

ENV GOPATH /go
ENV GOROOT /usr/local/go

# Set environment variables.
ENV PATH=${GOROOT}/bin:${GOPATH}/bin:$PATH

RUN set -eux; apt-get update; apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	; rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/go/bin:$PATH

RUN set -eux; \
	arch="$(dpkg --print-architecture)"; arch="${arch##*-}"; \
	url=; \
	case "$arch" in \
		'amd64') \
            url='https://dl.google.com/go/go1.22.4.linux-amd64.tar.gz'; \
            sha256='ba79d4526102575196273416239cca418a651e049c2b099f3159db85e7bade7d'; \
			;; \
		'arm64') \
            url='https://dl.google.com/go/go1.22.4.linux-arm64.tar.gz'; \
            sha256='a8e177c354d2e4a1b61020aca3562e27ea3e8f8247eca3170e3fa1e0c2f9e771'; \
			;; \
		*) echo >&2 "error: unsupported architecture '$arch' (likely packaging update needed)"; exit 1 ;; \
	esac; \
	build=; \
	\
	wget -O go.tgz.asc "$url.asc"; \
	wget -O go.tgz "$url" --progress=dot:giga; \
	echo "$sha256 *go.tgz" | sha256sum -c -; \
	\
	# https://github.com/golang/go/issues/14739#issuecomment-324767697 \
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
	# https://www.google.com/linuxrepositories/ \
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub |  gpg --import - ; \
	gpg --batch --verify go.tgz.asc go.tgz; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" go.tgz.asc; \
	\
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	\
	go version; \
	\
	mkdir -p "$GOPATH/src" "$GOPATH/bin"; \
	chmod -R 1777 "$GOPATH"; \
	chown -R worker $GOROOT $GOPATH

WORKDIR $GOPATH

# Frequently used go packages.
RUN go install golang.org/x/tools/cmd/cover@latest \
 && go install golang.org/x/lint/golint@latest \
 && go install github.com/tools/godep@latest \
 && go install github.com/laher/goxc@latest \
 && go install github.com/onsi/ginkgo/v2/ginkgo@latest \
 && go install github.com/onsi/gomega/...@latest

