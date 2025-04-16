#!/bin/bash

# macOS Setup Script
# This script installs the following applications:
# 1. HomeBrew
# 2. WezTerm
# 3. Starship
# 4. Git
# 5. Golang
# 6. Python
# 7. Firefox

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print section headers
print_header() {
    echo "========================================"
    echo "  $1"
    echo "========================================"
}

# Check if running with sudo
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run this script with sudo. Homebrew should be installed as a non-root user."
    exit 1
fi

# 1. Install Homebrew
print_header "Installing Homebrew"
if command -v brew &>/dev/null; then
    echo "Homebrew is already installed."
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for the current session
    if [[ $(uname -m) == "arm64" ]]; then
        # For M1/M2 Macs
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # For Intel Macs
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    echo "Homebrew installed successfully!"
fi

# 2. Install WezTerm
print_header "Installing WezTerm"
if brew list --cask wezterm &>/dev/null; then
    echo "WezTerm is already installed."
else
    echo "Installing WezTerm..."
    brew install --cask wezterm
    echo "WezTerm installed successfully!"
fi

# 3. Install Starship
print_header "Installing Starship"
if command -v starship &>/dev/null; then
    echo "Starship is already installed."
else
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh
    
    # Add Starship to shell config if not already there
    if [[ -f ~/.zshrc ]] && ! grep -q "starship init zsh" ~/.zshrc; then
        echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    elif [[ -f ~/.bashrc ]] && ! grep -q "starship init bash" ~/.bashrc; then
        echo 'eval "$(starship init bash)"' >> ~/.bashrc
    fi
    
    echo "Starship installed successfully!"
fi

# 4. Install Git
print_header "Installing Git"
if brew list git &>/dev/null; then
    echo "Git is already installed."
else
    echo "Installing Git..."
    brew install git
    echo "Git installed successfully!"
fi

# 5. Install Golang
print_header "Installing Golang"
if brew list go &>/dev/null; then
    echo "Golang is already installed."
else
    echo "Installing Golang..."
    brew install go
    
    # Set up Go environment variables if not already set
    if ! grep -q "GOPATH" ~/.zshrc && ! grep -q "GOPATH" ~/.bashrc; then
        echo 'export GOPATH=$HOME/go' >> ~/.zprofile
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.zprofile
    fi
    
    echo "Golang installed successfully!"
fi

# 6. Install Python
print_header "Installing Python"
if brew list python &>/dev/null; then
    echo "Python is already installed."
else
    echo "Installing Python..."
    brew install python
    echo "Python installed successfully!"
    
    # Install pip if not installed
    if ! command -v pip &>/dev/null; then
        echo "Installing pip..."
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python3 get-pip.py
        rm get-pip.py
    fi
fi

# 7. Install Firefox
print_header "Installing Firefox"
if brew list --cask firefox &>/dev/null; then
    echo "Firefox is already installed."
else
    echo "Installing Firefox..."
    brew install --cask firefox
    echo "Firefox installed successfully!"
fi

print_header "Installation Complete!"
echo "All requested applications have been installed:"
echo "1. HomeBrew"
echo "2. WezTerm"
echo "3. Starship"
echo "4. Git"
echo "5. Golang"
echo "6. Python"
echo "7. Firefox"
echo ""
echo "You may need to restart your terminal for some changes to take effect."
