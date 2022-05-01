all: install;

install:
	ansible-galaxy role install -r requirements.yml
	ansible-galaxy collection install -r requirements.yml

rtx1210:
	ansible-playbook rtx1210.yml -i inventories/$${ENV:-prod} -K

proxmox:
	ansible-playbook proxmox.yml -i inventories/$${ENV:-prod} -K

diskstation:
	ansible-playbook diskstation.yml -i inventories/$${ENV:-prod} -K
