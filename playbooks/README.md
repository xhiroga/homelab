# Playbooks

Configuration for bare-metal machines.

## Prerequisites

1. [Connected to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).
2. Clone This repository

## macOS

> [!NOTE]
> This macOS playbooks assumes that the control node and the target host are the same macOS system.

### Run

```shell
make -C .. install
make macos
```

## YAMAHA RTX1210

### Prerequisites

```rtx
login password
administrator password
login user {{ user }} {{ password }}
sshd host key generate
sshd service on
```

### Run

```shell
make -C .. install
make rtx1210
```

### References

- [コマンドリファレンス](http://www.rtpro.yamaha.co.jp/RT/manual/rt-common/index.html)
- [Ansibleによる運用自動化について](http://www.rtpro.yamaha.co.jp/RT/docs/ansible/index.html)

## Proxmox

### Run

```shell
make -C .. install
make proxmox
```

## Synology NAS Diskstation

### Prerequisites

- コントロールパネル > 端末とSNMP > 端末 > SSHサービスを有効化する。
- AdministratorグループのユーザーでSSH接続した後、公開鍵を登録する。

### Run

```shell
make -C .. install
make diskstation
```

### References and Inspiration

- [Synology DiskStation で SSH 接続を公開鍵認証方式にする - Qiita](https://qiita.com/shimizumasaru/items/56474d98e723ea1b5ae3)
- [CLI Administrator Guide for Synology NAS](https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/All/enu/Synology_DiskStation_Administration_CLI_Guide.pdf)

## WSL

> [!NOTE]
> This WSL playbooks assumes that the control node and the target host are the same WSL system.

### Run from Local Repository

```powershell
# https://learn.microsoft.com/ja-jp/windows/wsl/wsl-config#wslconfig
Copy-Item -Path ./files/windows/.wslconfig -Destination "$env:USERPROFILE\.wslconfig"

# wsl --install
wsl
# Install Homebrew manually.
```

```shell
make wsl
```

## Windows

### Prerequisites

OpenSSH Serverのセットアップは次の通り手動で行う。`winrm`を用いてAnsibleで設定する案もあったが、`hosts`にユーザー名やパスワードを記載する必要があり、Vaultの導入などが必要になること、そもそもSSHは初回に設定するのみであること等から、手動の方針とした。

```powershell
# !!! Run PowerShell as Administrator !!!
# 「OpenSSH for Windows の 2024 年 10 月の更新について」にある通り、sshd起動時のチェックが厳格になったため、サービス開始に先立ってファイルの設定を行う。
# https://jpwinsup.github.io/blog/2024/11/12/OpenSSH/OpenSSH_update_oct_2024/

# https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
# Windowsのsshdは、管理者ユーザーグループのユーザーのsshでは authorized_keys の代わりに administrators_authorized_keys を参照する
$keysUrl = "https://github.com/xhiroga.keys"
$authorizedKeysPath = "C:\ProgramData\ssh\administrators_authorized_keys"

Invoke-RestMethod -Uri $keysUrl | Add-Content -Path $authorizedKeysPath -Force
Get-Content "C:\ProgramData\ssh\administrators_authorized_keys"

icacls.exe $authorizedKeysPath /inheritance:r /grant "*S-1-5-32-544:F" /grant "SYSTEM:F"
Get-Acl "C:\ProgramData\ssh\administrators_authorized_keys" | Format-List *
# GUIで確認するとユーザーに書き込み権限が付与されてしまうため不可

# https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh-server-configuration
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
# Start the sshd service
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
Get-Service -Name sshd

if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}
```

設定後、`wsl`から疎通確認する。

### Run from Local Repository

```powershell
wsl
make windows
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
