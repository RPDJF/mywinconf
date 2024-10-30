$newConf = "./assets/configs/terminal_settings.json"
$oldConf = Join-Path -Path ([System.Environment]::GetFolderPath('LocalApplicationData')) -ChildPath "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# Check if settings file exists
if (!(Test-Path $newConf)) {
	Write-Host "Settings file not found" -ForegroundColor Red
	exit
}
elseif (!(Test-Path $oldConf)) {
 	Write-Host "Old settings file not found at " $oldConf -ForegroundColor Red
	exit
}

# Copy settings file
Copy-Item -Path $newConf -Destination $oldConf -Force

if ($?) {
	Write-Host "Settings updated successfully" -ForegroundColor Green
} else {
	Write-Host "Settings update failed" -ForegroundColor Red
}