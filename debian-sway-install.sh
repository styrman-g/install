#!/bin/bash
# A script for a new install of sway on debian minimal install.

# First updating the system.
echo "Updating system"
sudo apt update && sudo apt upgrade

# Installing important programs first
echo "Installing basic programs"
sudo apt install git stow zip unzip network-manager network-manager-gnome nwg-look thunar wlogout

# Installing sway
echo "Do you want to install SWAY? (yes/no)"
read answer

if [ "$answer" = "yes" ]; then
    echo "Installing Sway with dependencis."
    sudo apt install sway waybar rofi alacritty dunst swaylock swayidle swaybg xdg-desktop-portal-wlr xwayland
elif [ "$answer" = "no" ]; then
    echo "Do not install Sway"
else
    echo "Answer 'yes' or 'no'."
fi

# Install a window manager
echo " Do you want to install Ly or SDDM? (ly/sddm)"
read answer

if [ "$answer" = "ly" ]; then
    echo "Installing Ly-Display manager"
    sudo apt update
    sudo apt install build-essential libpam0g-dev libxcb-xkb-dev git
    git clone --recurse-submodules https://github.com/nullgemm/ly.git
    cd ly
    make
    sudo make install
    sudo systemctl enable ly
elif [ "$answer" = "sddm" ]; then
    echo "Installing SDDM"
    sudo apt install sddm
    sudo systemctl enable sddm
    echo "Setting up a theme for SDDM"
    git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh
else
    echo "Do not install a Display Manager"
fi


# Install my dotfiles
echo "Do you want to install styrmans dotfiles? (yes/no)"
read answer

if [ "$answer" = "yes" ]; then
    echo "Cloning my dotfiles"
    cd
    git clone https://github.com/styrman-g/dotfiles.git
    sudo apt install lsd curl
    cd
    curl -sS https://starship.rs/install.sh | sh
elif [ "$answer" = "no" ]; then
    echo "Dont want styrmans dotfiles???? ok."
else
    echo "Answer yes or no please"
fi

# Install emacs
echo "Do you want to install Doom-emacs? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    echo "First install emacs"
    sudo apt install emacs-gtk
    cd
    echo "Installing Doom"
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ~/.config/emacs/bin/doom install
    cd
    rm -rf .bashrc
    cd .config
    rm -rf /doom
    cd
    cd dotfiles
    stow .
    cd
    doom sync
elif [ "$answer" = "n" ]; then
    echo "Setting up emacs later"
else
    echo "Do nothing"
fi

# Install fonts
echo "Do you want to install styrmans fonts? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    # 1. Create font directory
    mkdir -p ~/.local/share/fonts
    cd
    # 2. Download the font (JetBrainsMono Nerd Font)
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
    # 3. Unzip the file
    unzip JetBrainsMono.zip -d ~/.local/share/fonts
    # 4. Remove the zip file
    rm JetBrainsMono.zip
    # 5. Refresh font cache
    fc-cache -fv
elif [ "$answer" = "n" ];then
    echo "No fonts installed"
else
    echo "OK"
fi

# Install flatpaks
# ställ fråga
