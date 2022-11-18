# Environment Variables
[System.Environment]::SetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", "1", [EnvironmentVariableTarget]::Machine)

# Windows Features
# List features: Get-WindowsOptionalFeature -Online
Enable-WindowsOptionalFeature -Online -FeatureName "Containers" -All
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V" -All
Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All

# Fonts
start "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip"

# Office
winget install --id "9MSPC6MP8FM4" # Microsoft Whiteboard
winget install --id "Notepad2mod.Notepad2mod" --interactive --scope machine

# Utilities
winget install --id "7zip.7zip" --interactive --scope machine

winget install --id "XP89DCGQ3K6VLD" # Microsoft Power Toys
$PowerToysBackupPath = "C:\Users\${env:UserName}\Documents\PowerToys\Backup";
Copy-Item -Path "./PowerToys/settings.ptb" -Destination $PowerToysBackupPath
Write-Output "Restore Power Toys backup froṁ: $PowerToysBackupPath"
Write-Output "";

winget install --id "9NJ3KMH29VGJ" # Enpass
winget install --id "WinSCP.WinSCP" --interactive --scope machine
winget install --id "9WZDNCRFJ3PV" # Windows Scan
winget install --id "9P7KNL5RWT25" # Sysinternals Suite

# Pheripherals
winget install --id "Elgato.ControlCenter" --interactive --scope machine
winget install --id "Elgato.StreamDeck" --interactive --scope machine

# Browsers
winget install --id "Google.Chrome" --interactive --scope machine
winget install --id "Mozilla.Firefox" --interactive --scope machine

# Communication
winget install --id "XPDC2RH70K22MN" # Discord
winget install --id "Microsoft.Teams" --interactive --scope machine
winget install --id "OpenWhisperSystems.Signal" --interactive --scope machine
winget install --id "9WZDNCRDK3WP" # Slack
winget install --id "9WZDNCRFJ140" # Twitter
winget install --id "XP99J3KP4XZ4VV" # Zoom

# Images
winget install --id "9N3SQK8PDS8G" # Screen To Gif
start "https://www.getpaint.net/download.html" # Paint.NET not yet available on winget

# Media
winget install --id "XPDM1ZW6815MQM" # VLC
winget install --id "plex.plexmediaplayer" --interactive --scope machine
winget install --id "OBSProject.OBSStudio" --interactive --scope machine
winget install --id "dev47apps.DroidCam" --interactive --scope machine
winget install --id "XSplit.VCam" --interactive --scope machine

# Terminal
winget install --id "9N0DX20HK701" # Windows Terminal
winget install --id "9MZ1SNWT0N5D" # PowerShell
winget install --id "JanDeDobbeleer.OhMyPosh" --interactive --scope machine
winget install --id "9P9TQF7MRM4R" # Windows Subsystem for Linux Preview
winget install --id "9NBLGGH4MSV6" # Ubuntu
winget install --id "9P804CRF0395" # Alpine

# Windows Terminal
Copy-Item -Path "./Terminal/settings.json" -Destination "C:\Users\${env:UserName}\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

# PowerShell Modules
Install-Module -Name PowerShellGet -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module -Name DockerCompletion -Scope CurrentUser

# PowerShell Profile
$ProfileDirectory = Split-Path $PROFILE;
Copy-Item -Path "./PowerShell/Microsoft.PowerShell_profile.ps1" -Destination $ProfileDirectory
Copy-Item -Path "./PowerShell/oh-my-posh.json" -Destination $ProfileDirectory

# Git
winget install --id "Git.Git" --interactive --scope machine
Copy-Item -Path "./Git/.gitconfig" -Destination "C:\Users\${env:UserName}"

winget install --id "GitHub.GitLFS" --interactive --scope machine
winget install --id "GitHub.cli" --interactive --scope machine
winget install --id "Axosoft.GitKraken" --interactive --scope machine

# Azure
winget install --id "Microsoft.AzureCLI" --interactive --scope machine
winget install --id "Microsoft.AzureCosmosEmulator" --interactive --scope machine
winget install --id "Microsoft.AzureDataStudio" --interactive --scope machine
winget install --id "Microsoft.AzureStorageEmulator" --interactive --scope machine
winget install --id "Microsoft.AzureStorageExplorer" --interactive --scope machine

# Tools
winget install --id "Docker.DockerDesktop" --interactive --scope machine
winget install --id "Microsoft.PowerBI" --interactive --scope machine
winget install --id "Pulumi.Pulumi" --interactive --scope machine
winget install --id "Telerik.Fiddler" --interactive --scope machine

# IDE's
winget install --id "Microsoft.VisualStudio.2022.Enterprise" --interactive --scope machine
winget install --id "Microsoft.VisualStudioCode" --interactive --scope machine

# Frameworks
start "https://github.com/coreybutler/nvm-windows/releases"
winget install --id "9PJPW5LDXLZ5" # Python
winget install --id "Microsoft.dotnet" --interactive --scope machine
