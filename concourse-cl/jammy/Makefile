ORG := genesiscommunity
NAME := concourse-cl
TAG := ubuntu-jammy
PLATFORM := linux/amd64


build:
	docker build -t $(ORG)/$(NAME):$(TAG) .

pub: build
	docker push $(ORG)/$(NAME):$(TAG)

test:
	docker run -it \
           -v ./tests/hello-world:/u/boot.lisp \
	   $(ORG)/$(NAME):$(TAG)
