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
echo "dotfiles_make_install_params:\n  GIT_USER_NAME: \"$GIT_USER_NAME\"\n  GIT_USER_EMAIL: \"$GIT_USER_EMAIL\"\n  ANSIBLE_PRIORITY_ROLES_PATH: \"$ANSIBLE_PRIORITY_ROLES_PATH\"\n  ANSIBLE_VALUE_PASSWORD_FILE: \"$ANSIBLE_VALUE_PASSWORD_FILE\"" > ./inventories/prod/group_vars/macos/local.yml
```

### References and Inspirations

- [geerlingguy/mac\-dev\-playbook: Mac setup and configuration via Ansible\.](https://github.com/geerlingguy/mac-dev-playbook)


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
