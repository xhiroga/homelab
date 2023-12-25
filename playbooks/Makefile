install_ssh_config:
	mkdir -p ~/.ssh/config.d
	ln -f ssh_config ~/.ssh/config.d/homelab_ssh_config

macos:
	rye run ansible-playbook macos.yml -i inventories/$${ENV:-prod} -K\
		-e "dotfiles_make_install_params=$${DOTFILES_MAKE_INSTALL_PARAMS}"

rtx1210:
	rye run ansible-playbook rtx1210.yml -i inventories/$${ENV:-prod} -K

proxmox:
	rye run ansible-playbook proxmox.yml -i inventories/$${ENV:-prod} -K

diskstation:
	rye run ansible-playbook diskstation.yml -i inventories/$${ENV:-prod} -K

ubuntu_dev:
	rye run ansible-playbook ubuntu_dev.yml -i inventories/$${ENV:-prod} -K

win_gpu:
	# [Preforking issue on OSX (10.13) when attempting to connect to windows server via WinRM · Issue #34056 · ansible/ansible](https://github.com/ansible/ansible/issues/34056)
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES rye run ansible win_gpu -i inventories/$${ENV:-prod} -m win_ping --ssh-common-args '-F ssh_config'
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES rye run ansible-playbook win_gpu.yml -i inventories/$${ENV:-prod}

win_vm_gpu:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES rye run ansible win_vm_gpu -i inventories/$${ENV:-prod} -m win_ping --ssh-common-args '-F ssh_config'
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES rye run ansible-playbook win_vm_gpu.yml -i inventories/$${ENV:-prod} --ssh-common-args '-F ssh_config'

win_vm:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES rye run ansible win_vm -i inventories/$${ENV:-prod} -m win_ping --ssh-common-args '-F ssh_config'
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES rye run ansible-playbook win_vm.yml -i inventories/$${ENV:-prod} --ssh-common-args '-F ssh_config'

wsl:
	rye run ansible-playbook wsl.yml -i inventories/$${ENV:-prod} -K\
		-e "dotfiles_make_install_params=$${DOTFILES_MAKE_INSTALL_PARAMS}"
