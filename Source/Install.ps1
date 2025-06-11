# Environment Variables
[System.Environment]::SetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", "1", [EnvironmentVariableTarget]::Machine)

# Windows Features
# List features: Get-WindowsOptionalFeature -Online
Enable-WindowsOptionalFeature -Online -FeatureName "Containers" -All
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V" -All
Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All

# Fonts
start "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip"

# Terminal
winget install --id "9N0DX20HK701"   # Windows Terminal
winget install --id "9MZ1SNWT0N5D"   # PowerShell
winget install --id "XP8K0HKJFRXGCK" # Oh My Posh

# IDE
winget install --id "Microsoft.VisualStudioCode" --interactive --scope machine
code --install-extension mms-dotnettools.csdevkit               # C# Dev Kit
code --install-extension ms-vscode.cpptools-extension-pack      # C/C++ Extension Pack
code --install-extension cake-build.cake-vscode                 # Cake
code --install-extension streetsidesoftware.code-spell-checker  # Code Spell Checker
code --install-extension ms-azuretools.vscode-docker            # Docker
code --install-extension EditorConfig.EditorConfig              # EditorConfig
code --install-extension dbaeumer.vscode-eslint                 # ESLint
code --install-extension GitHub.codespaces                      # GitHub Codespaces
code --install-extension GitHub.copilot                         # GitHub Copilot
code --install-extension GitHub.vscode-pull-request-github      # GitHub Pull Requests
code --install-extension codezombiech.gitignore                 # Gitignore
code --install-extension eamodio.gitlens                        # Git Lens
code --install-extension GraphQL.vscode-graphql-syntax          # GraphQL Syntax Highlighting
code --install-extension VisualStudioExptTeam.vscodeintellicode # Intellicode
code --install-extension Orta.vscode-jest                       # Jest
code --install-extension ms-vsliveshare.vsliveshare             # Live Share
code --install-extension yzhang.markdown-all-in-one             # Markdown All In One
code --install-extension christian-kohler.npm-intellisense      # NPM Intellisense
code --install-extension ms-vscode.PowerShell                   # PowerShell
code --install-extension esbenp.prettier-vscode                 # Prettier
code --install-extension mohsen1.prettify-json                  # Prettify JSON
code --install-extension ms-vscode-remote.remote-containers     # Remote Dev Containers
code --install-extension ms-vscode-remote.remote-wsl            # Remote WSL
code --install-extension humao.rest-client                      # REST Client
code --install-extension vscode-icons-team.vscode-icons         # VS Code Icons
code --install-extension Vue.volar                              # Vue Official
code --install-extension redhat.vscode-xml                      # XML
code --install-extension redhat.vscode-yaml                     # YAML
winget install --id "Microsoft.VisualStudio.2022.Enterprise" --interactive --scope machine

# Git
winget install --id "Git.Git" --interactive --scope machine
mkdir C:\GitHub
cd C:\GitHub
git clone https://github.com/RehanSaeed/Windows.git
cd Windows\Source
Copy-Item -Path "./Git/.gitconfig" -Destination "C:\Users\${env:UserName}"
winget install --id "GitHub.cli" --interactive --scope machine

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
& $PROFILE; # Reload PowerShell Profile

# Office
winget install --id "9MSPC6MP8FM4" # Microsoft Whiteboard

# Utilities
winget install --id "7zip.7zip" --interactive --scope machine     # 7Zip
winget install --id "XP89DCGQ3K6VLD"                              # Microsoft Power Toys
winget install --id "9NJ3KMH29VGJ"                                # Enpass
winget install --id "WinSCP.WinSCP" --interactive --scope machine # WinSCP
winget install --id "9WZDNCRFJ3PV"                                # Windows Scan

# Pheripherals
winget install --id "Elgato.ControlCenter" --interactive --scope machine # Elgato Control Center
winget install --id "Elgato.StreamDeck" --interactive --scope machine    # Elagto Stream Deck

# Browsers
winget install --id "Google.Chrome" --interactive --scope machine   # Chrome
winget install --id "Mozilla.Firefox" --interactive --scope machine # FireFox

# Communication
winget install --id "XPDC2RH70K22MN"                                          # Discord
winget install --id "Microsoft.Teams" --interactive --scope machine           # Teams
winget install --id "OpenWhisperSystems.Signal" --interactive --scope machine # Signal
winget install --id "9WZDNCRDK3WP"                                            # Slack
winget install --id "9NKSQGP7F2NH"                                            # WhatsApp
winget install --id "XP99J3KP4XZ4VV"                                          # Zoom

# Images
winget install --id "9N3SQK8PDS8G"                                     # Screen To Gif
winget install --id "dotPDN.PaintDotNet" --interactive --scope machine # Paint.NET

# Media
winget install --id "XPDM1ZW6815MQM"                                     # VLC
winget install --id "plex.plexmediaplayer" --interactive --scope machine # Plex
winget install --id "XSplit.VCam" --interactive --scope machine          # XSplit VCam

# Linux

winget install --id "9P9TQF7MRM4R" # Windows Subsystem for Linux
winget install --id "9NZ3KLHXDJP5" # Ubuntu 24.04.1 LTS
winget install --id "9P804CRF0395" # Alpine

# Azure
winget install --id "Microsoft.AzureCLI" --interactive                        # Azure CLI
winget install --id "Microsoft.AzureDataStudio" --interactive --scope machine # Azure Data Studio

# Tools
winget install --id "Docker.DockerDesktop" --interactive --scope machine # Docker Desktop
winget install --id "Microsoft.PowerBI" --interactive --scope machine    # Power BI
winget install --id "Pulumi.Pulumi" --interactive                        # Pulumi
winget install --id "Telerik.Fiddler.Everywhere" --interactive           # Fiddler

# Frameworks
winget install --id "CoreyButler.NVMforWindows" --interactive # NVM
winget install --id "9PNRBTZXMB4Z"                            # Python 3.13
winget install --id "Microsoft.DotNet.SDK.9" --interactive    # .NET SDK 9
