all: docker-build test;

docker-build:
	docker build ./molecule/docker-image -t xhiroga-ansible-role-dev

converge: docker-build;
	poetry run molecule converge

destroy:
	poetry run molecule destroy

login:
	poetry run molecule login

test: docker-build;
	poetry run molecule test
