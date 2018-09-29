IMAGE := mtneug/freetz
all: lint build

build:
	docker build -t $(IMAGE) .
.PHONY: build

clean:
	-docker rmi $(IMAGE)
.PHONY: clean

lint:
	shellcheck *.sh
.PHONY: lint
