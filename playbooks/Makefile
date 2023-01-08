inventories/prod/group_vars/macos/local.yml:
	echo "com_apple_screencapture_location: $${COM_APPLE_SCREENCAPTHRE_LOCATION}" > $@
	echo "alfred_sync_folder: $${ALFRED_SYNC_FOLDER}" >> $@
	echo "dotfiles_make_install_params:\n  GIT_USER_NAME: \"$${GIT_USER_NAME}\"\n  GIT_USER_EMAIL: \"$${GIT_USER_EMAIL}\"\n  ANSIBLE_VALUE_PASSWORD_FILE: \"$${ANSIBLE_VALUE_PASSWORD_FILE}\"" >> $@

macos: inventories/prod/group_vars/macos/local.yml;
	poetry run ansible-playbook macos.yml -i inventories/$${ENV:-prod} -K

rtx1210:
	poetry run ansible-playbook rtx1210.yml -i inventories/$${ENV:-prod} -K

proxmox:
	poetry run ansible-playbook proxmox.yml -i inventories/$${ENV:-prod} -K

diskstation:
	poetry run ansible-playbook diskstation.yml -i inventories/$${ENV:-prod} -K

ubuntu_dev:
	poetry run ansible-playbook ubuntu_dev.yml -i inventories/$${ENV:-prod} -K

windows_home_ping:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible windows_home -i inventories/$${ENV:-prod} -m win_ping
	# [Preforking issue on OSX \(10\.13\) when attempting to connect to windows server via WinRM · Issue \#34056 · ansible/ansible](https://github.com/ansible/ansible/issues/34056)

windows_home: windows_home_ping;
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible-playbook windows_home.yml -i inventories/$${ENV:-prod}

windows_gpu:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible-playbook windows_gpu.yml -i inventories/$${ENV:-prod}

wsl:
	poetry run ansible-playbook wsl.yml -i inventories/$${ENV:-prod} -K
