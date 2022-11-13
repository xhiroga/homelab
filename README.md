# Homelab

[@xhiroga](https://github.com/xhiroga)'s homelab.


## Prerequisites

Install [Poetory](https://python-poetry.org/).

```shell
poetry install
```

## macOS

### Prerequisites

```shell
# Set environment variables
echo "dotfiles_make_install_params:\n  GIT_USER_NAME: \"$GIT_USER_NAME\"\n  GIT_USER_EMAIL: \"$GIT_USER_EMAIL\"\n  ANSIBLE_PRIORITY_ROLES_PATH: \"$ANSIBLE_PRIORITY_ROLES_PATH\"\n  ANSIBLE_VALUE_PASSWORD_FILE: \"$ANSIBLE_VALUE_PASSWORD_FILE\"" > ./inventories/prod/group_vars/macos/local.yml
```

### from collection

```shell
ansible-galaxy collection install git@github.com:xhiroga/homelab.git,feat/homelab-as-a-ansible-collection
# Role dependencies looks not installed automatically. [How to install ansible galaxy a collection's role dependencies? \- Stack Overflow](https://stackoverflow.com/questions/60829595/how-to-install-ansible-galaxy-a-collections-role-dependencies)
ansible-galaxy role install -r https://raw.githubusercontent.com/xhiroga/homelab/feat/homelab-as-a-ansible-collection/requirements.yml
ansible-playbook xhiroga.homelab.macos -e 'target=localhost' -c local -i localhost, -K
```

## from local

```shell
ansible-playbook -c local -i localhost, playbooks/debug.yml
```

## References and Inspirations

- [khuedoan/homelab: Small and energy efficient self\-hosting infrastructure, fully automated from empty disk to operating services\.](https://github.com/khuedoan/homelab)
- [Launching a Windows VM in Proxmox](https://www.youtube.com/watch?v=eyNlGAzf-L4)
