#!/bin/bash
# A script for a new install of sway on fedora linux.

# first update the system
echo "Updating system"
sudo dnf update

# Installing important programs
echo "Installing basic programs"
sudo dnf install git stow alacritty sway waybar rofi dunst swaylock swayidle foot xorg-x11-server-Xwayland polkit

# Install sddm with a theme
echo "Do you want to install SDDM? (yes/no)"
read answer

if [ "$answer" = "yes" ]; then
    echo "Härligt! Det är ett kraftfullt verktyg."
elif [ "$answer" = "no" ]; then
    echo "Do not install SDDM"
else
    echo "Answer 'yes' or 'no'."
fi
