.PHONY:

requirements:
	rye run ansible-galaxy role install -r requirements.yml
	rye run ansible-galaxy collection install -r requirements.yml

clean-macos-prerequisites:
	rm -rf ~/.ssh
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	rm -rf ~/.ansible/collections/ansible_collections

install_ssh_config:
	mkdir -p ~/.ssh/config.d
	ln -f ssh_config ~/.ssh/config.d/homelab_ssh_config
