all: requirements;

requirements:
	poetry run ansible-galaxy collection install -p ~/.ansible/roles -r requirements.yml
	poetry run ansible-galaxy role install -p ~/.ansible/roles -r requirements.yml

ubuntu_dev:
	poetry run ansible-playbook ubuntu_dev.yml -i inventories/$${ENV:-prod} -K

windows_dev_ping:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible windows_dev -i inventories/$${ENV:-prod} -m win_ping
	# [Preforking issue on OSX \(10\.13\) when attempting to connect to windows server via WinRM · Issue \#34056 · ansible/ansible](https://github.com/ansible/ansible/issues/34056)

windows_dev: windows_dev_ping;
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible-playbook windows_dev.yml -i inventories/$${ENV:-prod}
