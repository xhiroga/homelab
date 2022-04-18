all: docker-build test;

docker-build:
	docker build ./molecule/docker-image -t ghcr.io/xhiroga/ansible-role-proxmox

converge: docker-build;
	poetry run molecule converge

destroy:
	poetry run molecule destroy

login:
	poetry run molecule login

test: docker-build;
	poetry run molecule test
