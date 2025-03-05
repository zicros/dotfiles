function Reload-Path()
{
    Write-Output "Reloading path"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

Write-Output "Installing git"
winget install git.git

Write-Output "Installing python"
winget install python3

Reload-Path
