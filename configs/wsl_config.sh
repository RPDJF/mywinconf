#!/bin/bash

# Function to print messages in color
print_message() {
    local color=$1
    local message=$2
    echo -e "\e[${color}m${message}\e[0m"
}

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q "$1"
}

# Fixing 24.04 mess on WSL
print_message "34" "Fixing 24.04 mess"
if ! grep -q "^deb .*$ppa:oibaf/graphics-drivers" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository -y ppa:oibaf/graphics-drivers
fi
if ! grep -q "alias nautilus=" ~/.bashrc; then
    echo "alias nautilus='dbus-launch nautilus'" >> ~/.bashrc
fi

# Update and upgrade apt
print_message "34" "Updating apt..."
sudo apt update -qq > /dev/null 2>&1
print_message "34" "Upgrading apt..."
sudo apt upgrade -y -qq > /dev/null 2>&1

# Install packages
packages=("git" "make" "gcc" "g++" "python3" "nautilus" "wslu")

print_message "34" "Installing packages..."
for package in "${packages[@]}"; do
    if is_installed "$package"; then
        print_message "32" "$package is already installed"
    else
        print_message "34" "Installing $package..."
        sudo apt install -y -qq "$package" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            print_message "32" "$package installed successfully"
        else
            print_message "31" "Failed to install $package"
        fi
    fi
done

# Install minilibx dependencies
print_message "34" "Installing minilibx dependencies..."
sudo apt-get install -y -qq xorg libxext-dev zlib1g-dev libbsd-dev > /dev/null 2>&1
print_message "32" "Minilibx dependencies installed successfully"

# Clean up apt
print_message "34" "Cleaning up apt..."
sudo apt autoremove -y -qq > /dev/null 2>&1
sudo apt autoclean -y -qq > /dev/null 2>&1
sudo apt clean -y -qq > /dev/null 2>&1
print_message "32" "Apt cleaned up successfully"

# Check if ssh public key exists
if [ -f ~/.ssh/id_rsa.pub ]; then
	print_message "32" "SSH public key exists"
else
	print_message "34" "Generating SSH key pair..."
	ssh-keygen > /dev/null 2>&1
fi

# Add scripts for nautilus
# Create the Nautilus script directory if it doesn't exist
print_message "34" "Adding scripts for nautilus WSL"
mkdir -p ~/.local/share/nautilus/scripts
mkdir -p ~/.local/share/applications

# Create the open_with_wslview.sh script
cat << 'EOF' > ~/.local/share/nautilus/scripts/open_with_wslview.sh
#!/bin/bash
wslview "$1"
EOF

# Make the script executable
chmod +x ~/.local/share/nautilus/scripts/open_with_wslview.sh

# Create the .desktop file for the custom action
cat << 'EOF' > ~/.local/share/applications/wslview.desktop
[Desktop Entry]
Name=Open with WSLView
Exec=wslview %f
Type=Application
Terminal=false
Icon=utilities-terminal
MimeType=application/octet-stream;
EOF

# Update the MIME database
update-desktop-database ~/.local/share/applications

# Set the default application for files
xdg-mime default wslview.desktop application/octet-stream

cat ~/.ssh/id_rsa.pub