$ProfileDirectory = Split-Path $PROFILE;
oh-my-posh init pwsh --config "$ProfileDirectory\oh-my-posh.json" | Invoke-Expression;

Import-Module Terminal-Icons
Import-Module DockerCompletion
Set-PSReadLineOption -PredictionViewStyle ListView

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

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
