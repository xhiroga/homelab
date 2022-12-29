# [Key-based authentication in OpenSSH for Windows | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement)
## Standard user
AUTHORIZED_KEY=$(cat ~/.ssh/id_ed25519.pub)
REMOTE_POWER_SHELL="powershell New-Item -Force -ItemType Directory -Path \$env:USERPROFILE\.ssh; Add-Content -Force -Path \$env:USERPROFILE\.ssh\authorized_keys -Value '$AUTHORIZED_KEY'"
ssh $WINDOWS_HOST $REMOTE_POWER_SHELL

## Administrative user
AUTHORIZED_KEY=$(cat ~/.ssh/id_ed25519.pub)
REMOTE_POWER_SHELL="powershell Add-Content -Force -Path \$env:ProgramData\ssh\administrators_authorized_keys -Value '$AUTHORIZED_KEY';icacls.exe \"\$env:ProgramData\ssh\administrators_authorized_keys\" /inheritance:r /grant \"Administrators:F\" /grant \"SYSTEM:F\""
ssh $WINDOWS_HOST $REMOTE_POWER_SHELL

# メモ帳で `$env:ProgramData\ssh\sshd_config` を開き、以下の行のコメントアウトを外す
# PubkeyAuthentication yes

# OpenSSH for Windows のサービスを再起動
ssh $WINDOWS_HOST "powershell Restart-Service sshd"
