# Setup Windows host for Ansible

param (
    [string]$githubUsername
)
if (-not $githubUsername) {throw "GitHub Username is not specified."}

## Install OpenSSH Server
# [OpenSSH をインストールする | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows-server/administration/openssh/openssh_install_firstuse)
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'

Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# [windowsのsshのシェルをcmd.exeから ps/wsl bashへ切り替える。 - それマグで！](https://takuya-1st.hatenablog.jp/entry/2022/03/04/171043)
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

$githubKeysUrl = "https://github.com/$githubUsername.keys"

try {
    $publicKeys = Invoke-WebRequest -Uri $githubKeysUrl -UseBasicParsing
    if (-not $publicKeys.Content) {
        throw "Cannot get public key from GitHub"
    }
} catch {
    throw "Error happened while fetching GitHub keys: $_"
}

$sshDirectory = "$env:USERPROFILE\.ssh"
New-Item -ItemType Directory -Path $sshDirectory -Force | Out-Null
Write-Host $sshDirectory
Get-ChildItem -Path $sshDirectory

$authorizedKeysFile = "$sshDirectory\authorized_keys"
Set-Content -Path $authorizedKeysFile -Value $publicKeys.Content -Force
Write-Host $authorizedKeysFile
Get-Content -Path $authorizedKeysFile

$adminAuthorizedKeysFile = "$env:ProgramData\ssh\administrators_authorized_keys"
Set-Content -Path $adminAuthorizedKeysFile -Value $publicKeys.Content -Force
Write-Host $adminAuthorizedKeysFile
Get-Content -Path $adminAuthorizedKeysFile

$configPath = "$env:ProgramData\ssh\sshd_config"
Write-Host "Before:"
(Get-Content $configPath) | Select-String "PubkeyAuthentication"

$config = Get-Content $configPath -Raw
$config = $config -replace '#\s*PubkeyAuthentication yes', 'PubkeyAuthentication yes'
$config = $config -replace '#\s*LogLevel INFO', 'LogLevel VERBOSE'
Set-Content $configPath -Value $config
Write-Host "After:"
(Get-Content $configPath) | Select-String "PubkeyAuthentication"

Restart-Service sshd
