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

ubuntu_dev:
	poetry run ansible-playbook ubuntu_dev.yml -i inventories/$${ENV:-prod} -K

windows_dev_ping:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible windows_dev -i inventories/$${ENV:-prod} -m win_ping
	# [Preforking issue on OSX \(10\.13\) when attempting to connect to windows server via WinRM · Issue \#34056 · ansible/ansible](https://github.com/ansible/ansible/issues/34056)

windows_dev: windows_dev_ping;
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible-playbook windows_dev.yml -i inventories/$${ENV:-prod}