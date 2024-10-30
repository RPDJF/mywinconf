$wsl_config =  "./configs/wsl_config.sh"

# Check if script file exists
if (!(Test-Path $wsl_config)) {
	Write-Host "Script file not found" -ForegroundColor Red
	exit
}

# Check if wsl ubuntu is installed
$WSL_LIST = wsl -l -q
if (!$WSL_LIST.Contains("Ubuntu")) {
	Write-Host "Ubuntu not found" -ForegroundColor Red
	# Install ubuntu
	Write-Host "Installing Ubuntu..." -ForegroundColor Yellow
	#wsl --install -d Ubuntu
	if ($LASTEXITCODE -eq 0) {
		Write-Host "Ubuntu installed successfully" -ForegroundColor Green
	} else {
		Write-Host "Ubuntu installation failed" -ForegroundColor Red
		exit
	}
}

# Install apps
Write-Host "Installing Ubuntu apps..." -ForegroundColor Yellow
wsl -d Ubuntu -e bash ./configs/wsl_config.sh
if ($?) {
	Write-Host "Ubuntu apps installed successfully" -ForegroundColor Green
} else {
	Write-Host "Ubuntu apps installation failed" -ForegroundColor Red
	exit
}
