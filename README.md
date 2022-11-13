# Homelab

[@xhiroga](https://github.com/xhiroga)'s homelab.


## Prerequisites

Install [Poetory](https://python-poetry.org/).

```shell
poetry install
```

## Run

```shell
ansible-galaxy collection install git@github.com:xhiroga/homelab.git
ansible-playbook run xhiroga.homelab.macos
```

## Debug

```shell
ansible-playbook -c local -i localhost, playbooks/debug.yml
```





## References and Inspirations

- [khuedoan/homelab: Small and energy efficient self\-hosting infrastructure, fully automated from empty disk to operating services\.](https://github.com/khuedoan/homelab)
- [Launching a Windows VM in Proxmox](https://www.youtube.com/watch?v=eyNlGAzf-L4)
