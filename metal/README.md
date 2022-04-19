# Metal

Configuration for bare-metal machines.

## Role Development

### Scaffolding

```shell
cd roles
poetry run molecule init role xhiroga.proxmox -d docker
```


## RTX1210

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