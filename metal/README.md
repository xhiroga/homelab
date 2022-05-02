# Metal

Configuration for bare-metal machines.

## Role Development

### Scaffolding

```shell
cd roles
poetry run molecule init role xhiroga.proxmox -d docker
```

## macOS

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


### References and Inspiration

- [Synology DiskStation で SSH 接続を公開鍵認証方式にする \- Qiita](https://qiita.com/shimizumasaru/items/56474d98e723ea1b5ae3)
- [CLI Administrator Guide for Synology NAS](https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/All/enu/Synology_DiskStation_Administration_CLI_Guide.pdf)
