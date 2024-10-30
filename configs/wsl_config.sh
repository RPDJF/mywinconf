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

# Update and upgrade apt
print_message "34" "Updating apt..."
sudo apt update -qq > /dev/null 2>&1
print_message "34" "Upgrading apt..."
sudo apt upgrade -y -qq > /dev/null 2>&1

# Install packages
packages=("git" "make" "gcc" "g++" "python3")

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
cat ~/.ssh/id_rsa.pub