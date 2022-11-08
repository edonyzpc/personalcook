.PHONY: anolis
anolis:
	docker build -f ./anolis-dev.dockerfile -t anolis-dev .

.PHONY: ubuntu
ubuntu:
	docker build -f ./ubuntu-dev.dockerfile -t ubuntu-dev .

.PHONY: startup
startup: ubuntu
	docker network create dev-net --subnet=10.11.0.0/16
	docker run --rm -d -p 2023:22 --name ubuntu-dev --net dev-net --ip 10.11.0.11 ubuntu-dev