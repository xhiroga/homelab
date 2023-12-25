# Playbooks

Configuration for bare-metal machines.

## Environment variables

Set environment variables.

```shell
export GIT_USER_NAME=xhiroga
export GIT_USER_EMAIL=xhiroga@users.noreply.github.com
export GIT_GHQ_ROOT=~/.ghq
```

## macOS

### Prerequisites

[Install Homebrew](https://docs.brew.sh/Installation).

[Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

```shell
ssh -T git@github.com
export DOTFILES_MAKE_INSTALL_PARAMS="{\"GIT_USER_NAME\":\"${GIT_USER_NAME}\",\"GIT_USER_EMAIL\":\"${GIT_USER_EMAIL}\",\"GIT_GHQ_ROOT\":\"${GIT_GHQ_ROOT}\"}"
```

### from collection

```shell
brew install ansible

ansible-galaxy collection install git@github.com:xhiroga/homelab.git
tmp=$(mktemp); curl -fsSL https://raw.githubusercontent.com/xhiroga/homelab/main/requirements.yml > ${tmp}.yml; ansible-galaxy role install -r ${tmp}.yml; rm ${tmp}.yml

ansible-playbook xhiroga.homelab.macos -e 'target=localhost' -e "dotfiles_make_install_params=${DOTFILES_MAKE_INSTALL_PARAMS}" -c local -i localhost, -K
```

Role dependencies are not installed automatically. See [How to install ansible galaxy a collection's role dependencies? - Stack Overflow](https://stackoverflow.com/questions/60829595/how-to-install-ansible-galaxy-a-collections-role-dependencies)

## from local

```shell
make -C .. install
make macos
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

### References and Inspiration

- [Synology DiskStation で SSH 接続を公開鍵認証方式にする - Qiita](https://qiita.com/shimizumasaru/items/56474d98e723ea1b5ae3)
- [CLI Administrator Guide for Synology NAS](https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/All/enu/Synology_DiskStation_Administration_CLI_Guide.pdf)

## WSL

### from local

```shell
export DOTFILES_MAKE_INSTALL_PARAMS="{\"GIT_USER_NAME\":\"${GIT_USER_NAME}\",\"GIT_USER_EMAIL\":\"${GIT_USER_EMAIL}\",\"GIT_GHQ_ROOT\":\"${GIT_GHQ_ROOT}\",\"GOMPLATE_OPTIONS\":\"--include .ssh/*,.gitconfig,.gitignore_global\"}"

make -C .. install
make wsl
```

## Windows (VM)

- `Get-NetIPAddress` in PowerShell
- Set TCP/IPv4 Properties as
  - Use the following IP addresses
    - IP address: `192.168.100.XXX`
    - Subnet mask: `255.255.255.0`
    - Default gateway: `192.168.100.1`
  - Use the following DNS server address
    - Preferred DNS server: `192.168.100.1`
- [Windows ホストのセットアップ — Ansible Documentation](https://docs.ansible.com/ansible/2.9_ja/user_guide/windows_setup.html#id3)
  - Microsoft Store > App Installer(Winget)
  - Configure OpenSSH Server

    ```powershell
    # Run as Administrator
    $OutputEncoding = New-Object -typename System.Text.UTF8Encoding
    Set-ExecutionPolicy RemoteSigned
    .\scripts\setup.ps1 -githubUsername "xhiroga"
    ```

### Debug SSH connection

1. Check sshd status
  1. `Commnad + R`, type `services.msc` and see `OpenSSH SSH Server`
  1. In Powershell, run `Get-Service --name sshd`
1. TODO

### Detect RegEdit Key/Value

1. Install `Sysinternals Suite`, like `winget install Sysinternals Suite`
2. Run `Procmon.exe`
3. (Depends on usecase) On Process Monitor Filter, only includes `Process Name is SystemSettings.exe`
4. Configure system settings and detect it!

### Resize Windows VM storage

- Select VM > Hardware > Select HDD > Resize disk > Input size (ex. 32GB)
- Boot VM
- Run `diskmgmt.msc`
- (For the first time only) See [Fix: Can’t Extend Volume in Windows](https://woshub.com/extend-volume-blocked-by-windows-recovery-partition/)
- Select `C:`, click `Extend volume...`

### Run PyTorch with NVIDIA GeForce Passthrough

- Install PyTorch
  - `conda install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia`
- Install GPU Driver.
- Check GPU Driver version.
  - Open `NVIDIA Control Panel` > `Desktop` > `System Information`. See Driver version (ex: `472.88`).
  - Run `nvidia-smi` on Command Prompt or PowerShell.
- Install CUDA Toolkit. See [required driver version](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#cuda-major-component-versions__table-cuda-toolkit-driver-versions).
- Check CUDA Driver version. Run `nvcc -V` on Command Propmt or Powershell. (ex. `Cuda compilation tools, release 11.7, V11.7.64`)
- Install Zlib. As this says, copy it into CUDA dll folder, instead of `C:\Windows\System32`
  - CUDAのアンインストール時に一緒に消せるメリットがある。一方で、CUDAのバージョンアップの都度インストールが必要な点は考慮すべき。
- Install cuDNN.
  - Refer cuDNN package version which supports installed CUDA Toolkit version. See [Support Matrix](https://docs.nvidia.com/deeplearning/cudnn/support-matrix/index.html).
  - See [Installing cuDNN on Windows | NVIDIA Developer](https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html).
  - インストーラーがない場合、解凍したフォルダを手動で`C:\Program Files\NVIDIA\CUDNN\v8.X(バージョンに依存)`に配置する。
    - 基本的にパスは自由だが、あまりに自由だとあとで困るのでv8.3以前のインストーラーの挙動に倣う。
  - `C:\Program Files\NVIDIA\CUDNN\v8.X(バージョンに依存)\bin`にPATHを通す。
    - Check cuDNN PATH. Run `where cudnn64_*.dll` on **Command Prompt** (not PowerShell).

Notes

- Check PyTorch deps first. Some new CUDA versions are not supported by PyTorch.
- NVIDIA provides CUDA Driver and GPU Driver.

#### References

- [CUDA&cuDNN環境構築のためのバージョン確認方法（Windows）](https://shift101.hatenablog.com/entry/2022/02/27/200953)
- [Setting up and Configuring CUDA, CUDNN and PYTorch for Python Machine Learning.](https://jayanthkurup.com/setting-up-and-configuring-cuda-cudnn-and-pytorch-for-python-machine-learning/)
- [Windows でディープラーニング環境を整える | 金子邦彦研究室](https://www.kkaneko.jp/tools/win/tfstack.html)
- [Windows10で深層学習の環境を整える](http://hara-jp.com/_default/ja/Memo/Cuda_Win10.html)
