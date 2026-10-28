$ErrorActionPreference = 'Stop'
$profilePath = Join-Path $PSScriptRoot '..\Microsoft.PowerShell_profile.ps1'

function Assert-Profile {
    param([bool]$Condition, [string]$Message)

    if (-not $Condition) {
        throw $Message
    }
}

# Stub optional dependencies so these checks do not change installed modules.
function global:oh-my-posh {
    $global:ProfileTestPromptArguments = $args
    '$global:ProfileTestPromptInitialized = $true'
}

function global:Import-Module {
    param([string]$Name, [switch]$Global, [string]$ErrorAction)

    $global:ProfileTestImports.Add($Name)
    Assert-Profile $Global.IsPresent 'Deferred modules must be imported globally.'
    Assert-Profile ($ErrorAction -eq 'Stop') 'Module failures must be caught and reported.'
    if ($global:ProfileTestFailIcons -and $Name -eq 'Terminal-Icons') {
        throw 'Simulated Terminal-Icons import failure'
    }
}

function global:Set-PSReadLineOption {
    param([string]$PredictionViewStyle)

    $global:ProfileTestPredictionViewStyle = $PredictionViewStyle
}

function global:Register-ArgumentCompleter {
    param([switch]$Native, [string]$CommandName, [scriptblock]$ScriptBlock)

    Assert-Profile ($Native -and $CommandName -eq 'dotnet') 'The dotnet native completer must be registered.'
    $global:ProfileTestDotnetCompleter = $ScriptBlock
}

function global:dotnet {
    $global:ProfileTestDotnetArguments = $args
    'build'
}

try {
    $loaders = [System.Collections.Generic.List[System.Management.Automation.Job]]::new()
    $global:ProfileTestImports = [System.Collections.Generic.List[string]]::new()
    $global:ProfileTestFailIcons = $false
    . $profilePath

    Assert-Profile $global:ProfileTestPromptInitialized 'The prompt must initialize immediately.'
    Assert-Profile ($global:ProfileTestPredictionViewStyle -eq 'ListView') 'Prediction settings changed.'
    Assert-Profile ($global:ProfileTestImports.Count -eq 0) 'Optional modules loaded during startup.'
    $configIndex = [array]::IndexOf($global:ProfileTestPromptArguments, '--config')
    $expectedConfig = Join-Path (Split-Path (Resolve-Path $profilePath)) 'oh-my-posh.json'
    Assert-Profile ($global:ProfileTestPromptArguments[$configIndex + 1] -eq $expectedConfig) 'The prompt must use the adjacent theme.'

    foreach ($name in '??', 'git?', 'gh?') {
        Assert-Profile (Test-Path -LiteralPath "Function:\$name") "Missing CLI shortcut: $name"
    }

    $completion = & $global:ProfileTestDotnetCompleter 'dotnet' 'dotnet bu' 9
    Assert-Profile ($completion -is [System.Management.Automation.CompletionResult]) 'The dotnet completer must return completion results.'
    Assert-Profile ($completion.CompletionText -eq 'build') 'The dotnet completion text changed.'
    Assert-Profile (($global:ProfileTestDotnetArguments -join '|') -eq 'complete|--position|9|dotnet bu') 'The dotnet completion arguments changed.'

    . $profilePath
    $subscribers = @(Get-EventSubscriber -SourceIdentifier PowerShell.OnIdle |
        Where-Object { $_.Action.Name -eq 'Windows.Profile.Modules' })
    Assert-Profile ($subscribers.Count -eq 1) 'Reloading the profile duplicated the idle subscription.'
    $loader = $subscribers[0].Action
    $loaders.Add($loader)

    $null = New-Event -SourceIdentifier PowerShell.OnIdle
    $deadline = [DateTime]::UtcNow.AddSeconds(5)
    while ($global:ProfileTestImports.Count -lt 2 -and [DateTime]::UtcNow -lt $deadline) {
        Start-Sleep -Milliseconds 50
    }
    $null = Receive-Job -Job $loader

    Assert-Profile (($global:ProfileTestImports -join ',') -eq 'Terminal-Icons,DockerCompletion') 'The idle event must load both enhancements.'
    Assert-Profile (-not (Get-EventSubscriber -SourceIdentifier PowerShell.OnIdle -ErrorAction Ignore |
        Where-Object { $_.Action.Name -eq 'Windows.Profile.Modules' })) 'The idle subscription must unregister after loading.'

    $null = New-Event -SourceIdentifier PowerShell.OnIdle
    Start-Sleep -Milliseconds 100
    Assert-Profile ($global:ProfileTestImports.Count -eq 2) 'Enhancements loaded more than once.'

    $global:ProfileTestImports.Clear()
    $global:ProfileTestFailIcons = $true
    . $profilePath
    $loader = (Get-EventSubscriber -SourceIdentifier PowerShell.OnIdle |
        Where-Object { $_.Action.Name -eq 'Windows.Profile.Modules' }).Action
    $loaders.Add($loader)
    Write-Output 'Expecting a visible simulated Terminal-Icons import error:'
    $null = New-Event -SourceIdentifier PowerShell.OnIdle
    $deadline = [DateTime]::UtcNow.AddSeconds(5)
    while ($global:ProfileTestImports.Count -lt 2 -and [DateTime]::UtcNow -lt $deadline) {
        Start-Sleep -Milliseconds 50
    }
    $jobErrors = @()
    $null = Receive-Job -Job $loader -ErrorAction SilentlyContinue -ErrorVariable jobErrors
    Assert-Profile (($global:ProfileTestImports -join ',') -eq 'Terminal-Icons,DockerCompletion') 'An icon import failure must not prevent Docker completion from loading.'
    Assert-Profile ($jobErrors.Count -eq 1 -and $jobErrors[0] -match 'Simulated Terminal-Icons import failure') 'Only the simulated module failure should be recorded by the event job.'

    Write-Output 'Profile regression checks passed.'
}
finally {
    Get-EventSubscriber -SourceIdentifier PowerShell.OnIdle -ErrorAction Ignore |
        Where-Object { $_.Action.Name -eq 'Windows.Profile.Modules' } |
        Unregister-Event
    foreach ($loader in $loaders) {
        Remove-Job -Job $loader -Force
    }
    Remove-Item -LiteralPath Function:\oh-my-posh, Function:\Import-Module, Function:\Set-PSReadLineOption, Function:\Register-ArgumentCompleter, Function:\dotnet
    Get-Variable -Name ProfileTest* -Scope Global | Remove-Variable -Scope Global
}
