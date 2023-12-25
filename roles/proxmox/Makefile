all: docker-build test;

docker-build:
	docker build ./molecule/docker-image -t ghcr.io/xhiroga/ansible-role-proxmox

converge: docker-build;
	rye run molecule converge

destroy:
	rye run molecule destroy

login:
	rye run molecule login

test: docker-build;
	rye run molecule test
