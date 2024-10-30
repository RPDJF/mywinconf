# mywinconf
## My Windows Configuration
This is a collection of scripts and configuration files that I use to configure my Windows environment. It is a work in progress and I will be adding more scripts and configuration files as I go along.

## Features
### Installs some cli tools
- which
- gsudo
- git
- nvm
- neofetch

### Installs some apps
- Visual Studio Code
- Discord
- Vencord

### Configure Windows Terminal by overwriting the settings.json file

### Configure Ubuntu in WSL
- Installs ubuntu if not installed
- Runs the `configs/wsl_config.sh` script to configure Ubuntu

## Easy customization
You can easily customize the scripts and configuration files to suit your needs. Just fork the repository and make the changes you want.

## Configuration files
``install_apps.json`` and ``install_cli_apps.json``

This file contains the list of apps that will be installed by the `install_apps.ps1` and `install_cli_apps.ps1` scripts respectively.

### File structure
An array of objects:
- `name`: The name of the app to be shown in the console
- `id`: The id of the app in the winget database
- `args`: (optional) The arguments to be passed to the winget install command

``wsl_config.sh``
The script to be run in Ubuntu to configure it.