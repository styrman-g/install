#!/usr/bin/env bash
#
# install_ly_and_disable_sddm.sh
# -------------------------------------------------
# Installs the Ly display manager on Debian,
# disables SDDM, and enables Ly.
# -------------------------------------------------

set -euo pipefail   # safer scripting

# ------------------------------------------------------------------
# Helper: print status messages
# ------------------------------------------------------------------
log() {
    echo -e "\e[1;34m[+] $*\e[0m"
}

# ------------------------------------------------------------------
# 1. Update package index
# ------------------------------------------------------------------
log "Updating package lists..."
sudo apt-get update

# ------------------------------------------------------------------
# 2. Install Ly
# ------------------------------------------------------------------
log "Installing Ly display manager..."
sudo apt-get install -y ly

# ------------------------------------------------------------------
# 3. Disable SDDM (if it exists)
# ------------------------------------------------------------------
if systemctl is-enabled sddm.service >/dev/null 2>&1; then
    log "Disabling SDDM..."
    sudo systemctl disable sddm.service
    sudo systemctl stop sddm.service || true
else
    log "SDDM is not installed or already disabled."
fi

# ------------------------------------------------------------------
# 4. Enable Ly
# ------------------------------------------------------------------
log "Enabling Ly..."
sudo systemctl enable ly.service
sudo systemctl start ly.service

# ------------------------------------------------------------------
# 5. Verify the active display manager
# ------------------------------------------------------------------
log "Current display manager status:"
systemctl status ly.service | head -n 10

log "Installation complete! Reboot to test the new login manager."
