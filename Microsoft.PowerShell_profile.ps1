# Start oh-my-posh prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_lean.omp.json" | Invoke-Expression

# PSReadLine module for using vim mode
# This example emits a cursor change VT escape in response to a Vi mode change.
function OnViModeChange {
  if ($args[0] -eq 'Command') {
    # Set the cursor to a blinking block.
    Write-Host -NoNewLine "`e[1 q"
  } else {
    # Set the cursor to a blinking line.
    Write-Host -NoNewLine "`e[5 q"
  }
}

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Alias for opening file
Set-Alias -Name open -Value ii
Set-Alias -Name serial -Value ss
Set-Alias -Name unzip -Value Expand-Archive
Set-Alias -Name zip -Value Compress-Archive

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
