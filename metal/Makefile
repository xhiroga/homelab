all: install rtx1210;

install:
	ansible-galaxy role install -r requirement.yml
	ansible-galaxy collection install -r requirement.yml

rtx1210:
	ansible-playbook playbooks/rtx1210.yml -i inventories/$${ENV:-prod} -K

proxmox:
	ansible-playbook playbooks/proxmox.yml -i inventories/$${ENV:-prod} -K
