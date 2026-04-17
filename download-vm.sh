#!/usr/bin/env bash
# ================================================
# Download Helper for VM Installation
# ================================================
# Run on VM to download all install scripts
#
# Usage:
#   curl -fsSL <host-ip>:8000/download-vm.sh | bash
#
# ================================================

set -e

HOST_IP="${1:-192.168.122.1}"
PORT="${2:-8000}"

echo "Downloading from ${HOST_IP}:${PORT}..."

mkdir -p ~/i3setup/scripts

# Download main script
echo "  Downloading install.sh..."
curl -fsSL "http://${HOST_IP}:${PORT}/install.sh" -o ~/i3setup/install.sh

# Download scripts
for script in 01-update 02-mirror 03-packages 04-configs 05-theme; do
	echo "  Downloading ${script}.sh..."
	curl -fsSL "http://${HOST_IP}:${PORT}/scripts/${script}.sh" -o ~/i3setup/scripts/${script}.sh
done

# Make executable
chmod +x ~/i3setup/install.sh
chmod +x ~/i3setup/scripts/*.sh

echo ""
echo "Done! Run:"
echo "  cd ~/i3setup"
echo "  ./install.sh"
