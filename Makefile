IMAGE ?= helios-technologies/concourse-kite-resource
TAG   ?= $(shell git describe --tags --abbrev=0 2>/dev/null || echo "1.0.0")

.PHONY: default start

default: build start

build:
	@echo "Building $(IMAGE):$(TAG) docker image..."
	@docker build -t "$(IMAGE):$(TAG)" .

start: build
	@echo '> Starting "$(IMAGE):$(TAG)" container...'
	@docker run -it --name kitebox $(IMAGE):$(TAG) bash

clean:
	@docker rm -f kitebox
