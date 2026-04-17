#!/usr/bin/env bash
# ================================================
# Module 03: Install Packages
# ================================================

set -e

echo -e "\033[0;35m[03/05]\033[0m Installing packages..."

PACKAGES=(
	# Core i3 & X11
	"i3" "xorg" "xinit" "lightdm" "lightdm-gtk-greeter"

	# Status bar & compositor
	"polybar" "picom" "rofi"

	# Terminal & editor
	"stterm" "neovim"

	# Browser
	"firefox-esr"

	# Utilities
	"brightnessctl" "pulsemixer" "acpi"

	# Fonts
	"fonts-jetbrains-mono" "fonts-font-awesome"

	# Audio
	"pulseaudio" "pavucontrol"

	# CLI tools
	"git" "curl" "wget" "btop" "fzf" "zoxide" "eza" "yazi"

	# Bluetooth & Network
	"blueman" "network-manager-gnome"

	# Misc
	"xss-lock" "feh"
)

# Build package string
PKG_STRING="${PACKAGES[*]}"

echo "  Installing ${#PACKAGES[@]} packages..."
echo "  This may take a few minutes..."

$SUDO apt install -y $PKG_STRING

echo -e "\033[0;32m[OK]\033[0m Packages installed"
