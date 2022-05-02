all: install;

install:
	poetry run ansible-galaxy role install -r requirements.yml
	poetry run ansible-galaxy collection install -r requirements.yml

macos:
	poetry run ansible-playbook macos.yml -i inventories/$${ENV:-prod} -K

rtx1210:
	poetry run ansible-playbook rtx1210.yml -i inventories/$${ENV:-prod} -K

proxmox:
	poetry run ansible-playbook proxmox.yml -i inventories/$${ENV:-prod} -K

diskstation:
	poetry run ansible-playbook diskstation.yml -i inventories/$${ENV:-prod} -K
