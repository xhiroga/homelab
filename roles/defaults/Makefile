all: docker-build test;

docker-build:
	docker build ./molecule/docker-image -t xhiroga-ansible-role-defaults

converge: docker-build;
	uv run molecule converge

destroy:
	uv run molecule destroy

login:
	uv run molecule login

test: docker-build;
	uv run molecule test
