ORG := genesiscommunity
NAME := concourse-cl
TAG := ubuntu-jammy
PLATFORM := linux/amd64
SF_SBCL_VERSION := 2.4.5

.PHONY: build-pipeline-arg-file

build-pipeline-arg-file: export SF_SBCL_VERSION:=$(SF_SBCL_VERSION)
build-pipeline-arg-file:
	./build-pipeline-arg-file

docker:
	docker build \
	   --build-arg SF_SBCL_VERSION="$(SF_SBCL_VERSION)" \
	   --build-arg BUILD_DATE="$(shell date -u -Iminutes)" \
	   --build-arg VCS_URL="$(shell git ls-remote --get-url origin)" \
	   --build-arg VCS_REF="$(shell git rev-parse --short HEAD)" \
	   --platform $(PLATFORM) \
	   -t $(ORG)/$(NAME):$(TAG) .

publish: docker
	docker push $(ORG)/$(NAME):$(TAG)

test:
	docker run -it \
           -v ./tests/hello-world:/u/boot.lisp \
	   --platform $(PLATFORM) \
	   $(ORG)/$(NAME):$(TAG)
