.PHONY:

install: playbooks/roles;
	uv run ansible-galaxy role install -r requirements.yml
	uv run ansible-galaxy collection install -r requirements.yml

playbooks/roles:
	ln -s ./roles ./playbooks/roles

clean-macos-prerequisites:
	rm -rf ~/.ssh
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	rm -rf ~/.ansible/collections/ansible_collections
