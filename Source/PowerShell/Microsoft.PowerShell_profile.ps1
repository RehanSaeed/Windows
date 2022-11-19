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
