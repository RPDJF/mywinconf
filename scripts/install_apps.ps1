$APPS_CONF = Get-Content "./configs/install_apps.json"
$AVAIL_APPS = winget list

# Check if config file exists
if (!$APPS_CONF) {
	Write-Host "Config file not found"
	exit
}

# Convert json to object
$APPS_CONF = $APPS_CONF | ConvertFrom-Json

# Install apps
Write-Host "Installing apps..." -ForegroundColor Yellow
foreach ($app in $APPS_CONF) {
	if ($AVAIL_APPS | Select-String $app.name) {
		Write-Host $app.name " is already installed" -ForegroundColor Green
	} else {
		try {
			Write-Host "Installing " -NoNewline
			Write-Host $app.name -ForegroundColor Cyan -NoNewline
			Write-Host "..."
			winget install $app.id $app.args
			if ($LASTEXITCODE -eq 0) {
				Write-Host $app.name " installed successfully" -ForegroundColor Green
			} else {
				Write-Host $app.name " installation failed" -ForegroundColor Red
			}
		} catch {
			Write-Host $app.name " installation failed" -ForegroundColor Red
		}
	}
}