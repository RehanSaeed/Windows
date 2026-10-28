# Windows

## PowerShell profile

Copy `Source\PowerShell\Microsoft.PowerShell_profile.ps1` and
`Source\PowerShell\oh-my-posh.json` into the directory containing `$PROFILE`,
then open a new PowerShell window.

The prompt, PSReadLine predictions, dotnet completion, and CLI shortcuts are
initialized immediately. Terminal-Icons and DockerCompletion load once on the
first `PowerShell.OnIdle` event (after approximately 300 ms without input), rather
than delaying the first prompt. Listings and Docker tab completion issued before
that event use PowerShell's defaults. These imports still run on the main
runspace, so their cost is deferred, not eliminated. Module load failures are
printed in the terminal.

Run the isolated profile regression checks without loading your installed profile:

```powershell
pwsh -NoProfile -File .\Source\PowerShell\Tests\Profile.Tests.ps1
```
