windows_dev_ping:
	# [Preforking issue on OSX \(10\.13\) when attempting to connect to windows server via WinRM · Issue \#34056 · ansible/ansible](https://github.com/ansible/ansible/issues/34056)
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES poetry run ansible windows_dev -i inventories/$${ENV:-prod} -m win_ping

windows_dev:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES ansible-playbook windows_dev.yml -i inventories/$${ENV:-prod}
