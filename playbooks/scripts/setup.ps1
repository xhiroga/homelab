# Setup Windows host for Ansible

## Install OpenSSH Server
# [OpenSSH をインストールする | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows-server/administration/openssh/openssh_install_firstuse)
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'

Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# [windowsのsshのシェルをcmd.exeから ps/wsl bashへ切り替える。 - それマグで！](https://takuya-1st.hatenablog.jp/entry/2022/03/04/171043)
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# Enable Remote Desktop
