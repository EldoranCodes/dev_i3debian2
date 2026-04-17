#!/bin/bash

set -e

echo "[*] Backing up current sources.list..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak.$(date +%s)

echo "[*] Writing new sources.list (PH mirror + fallback)..."

sudo tee /etc/apt/sources.list >/dev/null <<EOF
# 🇵🇭 PH mirror (primary - faster)
deb http://mirror.rise.ph/debian/ bookworm main contrib non-free non-free-firmware
deb http://mirror.rise.ph/debian/ bookworm-updates main contrib non-free non-free-firmware
deb http://mirror.rise.ph/debian-security/ bookworm-security main contrib non-free non-free-firmware

# 🌍 Official Debian fallback (reliable)
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main
EOF

echo "[*] Cleaning APT cache..."
sudo apt clean

echo "[*] Updating package lists..."
sudo apt update

echo "[✔] Done. Your mirrors are now set."
