# Metal

Configuration for bare-metal machines.

## Role Development

### Scaffolding

```shell
cd roles
poetry run molecule init role proxmox -d docker
```

## macOS

### Prerequisites

```shell
# Set environment variables
export GIT_USER_NAME=xhiroga
export GIT_USER_EMAIL=13391129+xhiroga@users.noreply.github.com
export ANSIBLE_VALUE_PASSWORD_FILE~/.ssh/id_ed25519
```

### from collection

```shell
ansible-galaxy collection install git@github.com:xhiroga/homelab.git,feat/homelab-as-a-ansible-collection
# Role dependencies looks not installed automatically. [How to install ansible galaxy a collection's role dependencies? \- Stack Overflow](https://stackoverflow.com/questions/60829595/how-to-install-ansible-galaxy-a-collections-role-dependencies)
tmp=$(mktemp); curl -fsSL https://raw.githubusercontent.com/xhiroga/homelab/feat/homelab-as-a-ansible-collection/requirements.yml > ${tmp}.yml; ansible-galaxy role install -r ${tmp}.yml; rm ${tmp}.yml

ansible-playbook xhiroga.homelab.macos -e 'target=localhost' -e "dotfiles_make_install_params={\"GIT_USER_NAME\":\"${GIT_USER_NAME}\",\"GIT_USER_EMAIL\":\"${GIT_USER_EMAIL}\",\"ANSIBLE_VALUE_PASSWORD_FILE\":\"${ANSIBLE_VALUE_PASSWORD_FILE}\"}" -c local -i localhost, -K
```

## from local

```shell
ansible-playbook macos.yml -i inventories/${ENV:-prod} -K
```

### References and Inspirations

- [geerlingguy/mac-dev-playbook: Mac setup and configuration via Ansible.](https://github.com/geerlingguy/mac-dev-playbook)


## YAMAHA RTX1210

### Configuration

```
login password
administrator password
login user {{ user }} {{ password }}
sshd host key generate
sshd service on
```

### References and Inspirations

- [コマンドリファレンス](http://www.rtpro.yamaha.co.jp/RT/manual/rt-common/index.html)
- [Ansibleによる運用自動化について](http://www.rtpro.yamaha.co.jp/RT/docs/ansible/index.html)


## Synology NAS Diskstation

### Prerequisites

- コントロールパネル > 端末とSNMP > 端末 > SSHサービスを有効化する。
- AdministratorグループのユーザーでSSH接続した後、公開鍵を登録する。

## Windows

- `Get-NetIPAddress` in PowerShell
- Set TCP/IPv4 Properties as
    - Use the following IP addresses
        - IP address: `192.168.100.150` (or any other address)
        - Subnet mask: `255.255.255.0`
        - Default gateway: `192.168.100.1`
    - Use the following DNS server address
        - Preferred DNS server: `192.168.100.1`
- [Windows ホストのセットアップ — Ansible Documentation](https://docs.ansible.com/ansible/2.9_ja/user_guide/windows_setup.html#id3)
- Microsoft Store > App Installer(Winget)


### References and Inspiration

- [Synology DiskStation で SSH 接続を公開鍵認証方式にする \- Qiita](https://qiita.com/shimizumasaru/items/56474d98e723ea1b5ae3)
- [CLI Administrator Guide for Synology NAS](https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/All/enu/Synology_DiskStation_Administration_CLI_Guide.pdf)
