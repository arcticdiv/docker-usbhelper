LAUNCHER_VERSION ?= latest

build:
	docker build \
		-t arcticdiv/usbhelper:latest \
		--build-arg LAUNCHER_VERSION=$(LAUNCHER_VERSION) \
		.

.PHONY: build
