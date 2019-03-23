all: lint build

tools:
	docker build -t mtneug/freetz .
.PHONY: tools 

build:
	docker build -t mtneug/freetz .
.PHONY: build

clean:
	-docker rmi mtneug/freetz
.PHONY: clean

lint:
	shellcheck *.sh
.PHONY: lint
