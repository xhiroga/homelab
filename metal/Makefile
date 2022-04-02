all: install rtx;

install:
	ansible-galaxy role install -r requirement.yml
	ansible-galaxy collection install -r requirement.yml

rtx:
	ansible-playbook -i hosts.yml rtx/main.yml -K
