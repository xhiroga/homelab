~/.ssh/config.d/homelab.conf: ~/.ssh/config.d
	cp -f homelab.conf ~/.ssh/config.d/homelab.conf

~/.ssh/config.d:
	mkdir -p $@

# Reserved
macos:
	uv run ansible-playbook macos.yml -i inventories/$${ENV:-prod} -K

rtx1210:
	uv run ansible-playbook rtx1210.yml -i inventories/$${ENV:-prod} -K

proxmox:
	uv run ansible-playbook proxmox.yml -i inventories/$${ENV:-prod} -K

diskstation:
	uv run ansible-playbook diskstation.yml -i inventories/$${ENV:-prod} -K

windows:
	uv run ansible windows -i inventories/$${ENV:-prod} -m win_ping --ssh-common-args '-F ssh_config'
	uv run ansible-playbook windows.yml -i inventories/$${ENV:-prod}

wsl:
	uv run ansible-playbook wsl.yml -i inventories/$${ENV:-prod} -K

# On-Demand
ubuntu_aarch64_ondemand:
	uv run ansible-playbook ondemand_ubuntu_aarch64.yml -i ondemand.py --limit $$(uv run ondemand.py | fzf)

ubuntu_x86_64_ondemand:
	uv run ansible-playbook ondemand_ubuntu_x86_64.yml -i ondemand.py --limit $$(uv run ondemand.py | fzf)
