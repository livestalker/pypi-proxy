.PHONY: build bash run

image = pypi-proxy:latest
container = pypi-proxy

build:
	docker build . -t $(image)

bash: build
	docker run --rm -it $(image) /bin/bash

run: build
	docker run --name $(container) -p 7777:80 --env-file .env $(image)
