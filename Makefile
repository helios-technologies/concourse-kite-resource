IMAGE		?=		helios-technologies/concourse-kite-resource
TAG   	?=		$(shell git describe --tags --abbrev=0 2>/dev/null || echo "1.0.0")

.PHONY: build

build:
	echo "Building $(IMAGE):$(TAG)"
	docker build -t "$(IMAGE):$(TAG)" .

start: build
	docker run -it --name="kitebox" $(IMAGE):$(TAG) bash

clean:
	docker rm $(docker stop {kitebox})
