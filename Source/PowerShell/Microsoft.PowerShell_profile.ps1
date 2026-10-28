$ProfileDirectory = $PSScriptRoot;
oh-my-posh init pwsh --config "$ProfileDirectory\oh-my-posh.json" | Invoke-Expression;

# Load optional enhancements after the first prompt, when PowerShell is idle.
if (-not (Get-EventSubscriber -SourceIdentifier PowerShell.OnIdle -ErrorAction Ignore |
        Where-Object { $_.Action.Name -eq 'Windows.Profile.Modules' })) {
    $ProfileModuleLoader = Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -MaxTriggerCount 1 -Action {
        foreach ($module in 'Terminal-Icons', 'DockerCompletion') {
            try {
                Import-Module $module -Global -ErrorAction Stop
            }
            catch {
                $Host.UI.WriteErrorLine("PowerShell profile could not load ${module}: $_")
            }
        }
    }
    $ProfileModuleLoader.Name = 'Windows.Profile.Modules'
}

Set-PSReadLineOption -PredictionViewStyle ListView

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

## GitHub Copilot for CLI Aliases
function ?? { 
    $TmpFile = New-TemporaryFile
    github-copilot-cli what-the-shell ('use powershell to ' + $args) --shellout $TmpFile
    if ([System.IO.File]::Exists($TmpFile)) { 
        $TmpFileContents = Get-Content $TmpFile
            if ($TmpFileContents -ne $nill) {
            Invoke-Expression $TmpFileContents
            Remove-Item $TmpFile
        }
    }
}
function git? {
    $TmpFile = New-TemporaryFile
    github-copilot-cli git-assist $args --shellout $TmpFile
    if ([System.IO.File]::Exists($TmpFile)) {
        $TmpFileContents = Get-Content $TmpFile
            if ($TmpFileContents -ne $nill) {
            Invoke-Expression $TmpFileContents
            Remove-Item $TmpFile
        }
    }
}
function gh? {
    $TmpFile = New-TemporaryFile
    github-copilot-cli gh-assist $args --shellout $TmpFile
    if ([System.IO.File]::Exists($TmpFile)) {
        $TmpFileContents = Get-Content $TmpFile
            if ($TmpFileContents -ne $nill) {
            Invoke-Expression $TmpFileContents
            Remove-Item $TmpFile
        }
    }
}
