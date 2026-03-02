PLATFORM := linux/amd64

.PHONY: concourse concourse-jammy concourse-noble go cl-jammy cl-noble

concourse:
	docker build --platform $(PLATFORM) -t genesiscommunity/concourse:latest concourse/latest/

concourse-jammy:
	docker build --platform $(PLATFORM) -t genesiscommunity/concourse:ubuntu-jammy concourse/ubuntu-jammy/

concourse-noble:
	docker build --platform $(PLATFORM) -t genesiscommunity/concourse:ubuntu-noble concourse/ubuntu-noble/

go:
	docker build --platform $(PLATFORM) -t genesiscommunity/concourse-go:1.20 concourse-go/1.20/

cl-jammy: concourse-jammy
	cd concourse-cl/jammy && $(MAKE) PLATFORM="$(PLATFORM)" docker

cl-noble: concourse-noble
	cd concourse-cl/noble && $(MAKE) PLATFORM="$(PLATFORM)" docker
