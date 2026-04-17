#!/usr/bin/env bash
# ================================================
# Module 02: Setup Philippine Mirrors
# ================================================

set -e

echo -e "\033[0;35m[02/05]\033[0m Setting up Philippine mirrors..."

# Backup original sources
if [[ ! -f /etc/apt/sources.list.bak ]]; then
	$SUDO cp /etc/apt/sources.list /etc/apt/sources.list.bak
	echo "  Backed up original sources.list"
fi

# Philippine mirrors (CLOUDZEN & UPLB)
PH_MIRROR="http://mirror.cloudzen.tech/debian/"
# Backup mirror
PH_MIRROR_FALLBACK="http://mirror.upb.edu.ph/debian/"

echo "  Primary: ${PH_MIRROR}"
echo "  Fallback: ${PH_MIRROR_FALLBACK}"

# Create new sources.list with Philippine mirrors
$SUDO tee /etc/apt/sources.list >/dev/null <<'EOF'
# Debian Bookworm (12) - Philippine Mirrors

deb http://mirror.cloudzen.tech/debian/ bookworm main contrib non-free non-free-firmware
deb http://mirror.cloudzen.tech/debian/ bookworm-updates main contrib non-free non-free-firmware
deb http://mirror.cloudzen.tech/debian/ bookworm-backports main contrib non-free non-free-firmware

# Security updates
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

echo -e "\033[0;32m[OK]\033[0m Philippine mirrors configured"
echo "  Run 'sudo apt update' to refresh package lists"
