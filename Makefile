VERSION := $(shell git describe --always --tags --dirty)
IMAGE_NAME := md-slides-pdf-exporter
DEV_REGISTRY := astromechza

.PHONY: image
image:
	docker build -t $(DEV_REGISTRY)/$(IMAGE_NAME):$(VERSION) .

.PHONY: push
push: image
	docker push $(DEV_REGISTRY)/$(IMAGE_NAME):$(VERSION)
	docker tag $(DEV_REGISTRY)/$(IMAGE_NAME):$(VERSION) $(DEV_REGISTRY)/$(IMAGE_NAME):latest
	docker push $(DEV_REGISTRY)/$(IMAGE_NAME):latest
