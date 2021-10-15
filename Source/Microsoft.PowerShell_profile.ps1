Import-Module posh-git
Import-Module oh-my-posh
Import-Module Terminal-Icons
Import-Module DockerCompletion
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
# Set-PoshPrompt -Theme Paradox
Set-PoshPrompt -Theme "C:\Users\${env:UserName}\OneDrive - Microsoft\Documents\PowerShell\oh-my-posh.json"

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}