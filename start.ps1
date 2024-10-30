Write-Host "-----------------------------------" -ForegroundColor Yellow
Write-Host "mywinconf v1.0" -ForegroundColor Yellow
Write-Host "personal windows configuration script" -ForegroundColor Yellow
Write-Host "by: github.com/RPDJF" -ForegroundColor Yellow
Write-Host "-----------------------------------`n`n" -ForegroundColor Yellow

Write-Host "Running scripts..." -ForegroundColor Yellow
Write-Host "-----------------------------------`n" -ForegroundColor Yellow

$response = Read-Host "Install CLI apps? (y/n)"
if ($response -eq "y") {
	Write-Host "Installing CLI apps..." -ForegroundColor Yellow
	./scripts/install_cli_apps.ps1
	Write-Host ""
}

$response = Read-Host "Install apps? (y/n)"
if ($response -eq "y") {
	Write-Host "Installing apps..." -ForegroundColor Yellow
	./scripts/install_apps.ps1
	Write-Host ""
}

$response = Read-Host "Update terminal settings? (y/n)"
if ($response -eq "y") {
	Write-Host "Updating terminal settings..." -ForegroundColor Yellow
	./scripts/update_terminal_conf.ps1
	Write-Host ""
}

$response = Read-Host "Configure WSL? (y/n)"
if ($response -eq "y") {
	Write-Host "Configuring WSL..." -ForegroundColor Yellow
	./scripts/config_wsl.ps1
	Write-Host ""
}

Write-Host ""
Write-Host "-----------------------------------" -ForegroundColor Yellow
Write-Host "All scripts executed successfully" -ForegroundColor Green
Write-Host "-----------------------------------" -ForegroundColor Yellow