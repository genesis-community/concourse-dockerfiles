.PHONY: concourse concourse-noble go cl-jammy cl-noble

concourse:
	docker build -t genesiscommunity/concourse:latest concourse/latest/

concourse-noble:
	docker build -t genesiscommunity/concourse:ubuntu-noble concourse/ubuntu-noble/

go:
	docker build -t genesiscommunity/concourse-go:1.20 concourse-go/1.20/

cl-jammy:
	cd concourse-cl/jammy && $(MAKE) docker

cl-noble: concourse-noble
	cd concourse-cl/noble && $(MAKE) docker
