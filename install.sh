#!/usr/bin/env bash
# ================================================
# Debian i3wm Purple Theme - Main Installer
# ================================================
#
# Usage:
#   chmod +x install.sh
#   ./install.sh
#
# Transfer to VM:
#   Option 1: Git clone, then run
#   Option 2: HTTP server on host, curl files to VM
#   Option 3: SCP: scp -P 2222 -r ./* user@localhost:~/
#
# ================================================

set -e

PURPLE_BG="#2e2640"
PURPLE_BG_ALT="#5d4b73"
PURPLE_FG="#e8e3c9"
PURPLE_ACCENT="#8fa7c4"
PURPLE_SECONDARY="#c284a4"
PURPLE_BINDING="#c99ad1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/install.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() {
	echo -e "${PURPLE}[INFO]${NC} $1"
	echo "[$(date)] $1" >>"$LOG_FILE"
}

warn() {
	echo -e "${YELLOW}[WARN]${NC} $1"
	echo "[$(date)] WARN: $1" >>"$LOG_FILE"
}

error() {
	echo -e "${RED}[ERROR]${NC} $1"
	echo "[$(date)] ERROR: $1" >>"$LOG_FILE"
}

success() {
	echo -e "${GREEN}[OK]${NC} $1"
}

# Check if running as root
check_root() {
	if [[ $EUID -eq 0 ]]; then
		SUDO=""
	elif command -v sudo &>/dev/null; then
		SUDO="sudo"
	else
		error "Please run as root or install sudo"
		exit 1
	fi
}

# Ensure scripts are executable
ensure_executable() {
	if [[ -d "${SCRIPT_DIR}/scripts" ]]; then
		chmod +x "${SCRIPT_DIR}/scripts/"*.sh 2>/dev/null || true
	fi
}

# Banner
banner() {
	cat <<'EOF'

    ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║██╔════╝
    ██████╔╝██████╔╝██╔██╗ ██║███████╗██║██║  ███╗
    ██╔═══╝ ██╔══██╗██║╚██╗██║╚════██║██║██║   ██║
    ██║     ██║  ██║██║ ╚████║███████║██║╚██████╔╝
    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝

    Purple Theme Installer for Debian i3wm
    ─────────────────────────────────────────
EOF
}

# Main
main() {
	banner

	echo -e "${PURPLE}────────────────────────────────────────${NC}"
	echo "  Purple Theme Colors:"
	echo "    Background:  ${PURPLE_BG}"
	echo "    Accent:      ${PURPLE_ACCENT}"
	echo "    Secondary:   ${PURPLE_SECONDARY}"
	echo -e "${PURPLE}────────────────────────────────────────${NC}"
	echo ""

	check_root
	ensure_executable
	log "Starting Debian i3wm Purple Theme installation"

	# Run each module
	modules=(
		"01-update"
		"02-mirror"
		"03-packages"
		"04-configs"
		"05-theme"
	)

	for module in "${modules[@]}"; do
		module_path="${SCRIPT_DIR}/scripts/${module}.sh"
		if [[ -f "$module_path" ]]; then
			log "Running ${module}.sh..."
			if bash "$module_path"; then
				success "Completed ${module}.sh"
			else
				error "Failed ${module}.sh"
				warn "Check log: ${LOG_FILE}"
				exit 1
			fi
		else
			warn "Module ${module}.sh not found, skipping"
		fi
		echo ""
	done

	echo ""
	echo -e "${GREEN}╔═══════════════════════════════════════════╗${NC}"
	echo -e "${GREEN}║   Installation Complete!                  ║${NC}"
	echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}"
	echo ""
	echo "Next steps:"
	echo "  1. Reboot:     sudo reboot"
	echo "  2. Select 'i3' at lightdm login"
	echo "  Or run:        startx"
	echo ""
	echo "Keybinds:"
	echo "  Mod+Enter  → Terminal (st)"
	echo "  Mod+a      → Rofi (apps)"
	echo "  Mod+e      → File manager"
	echo "  Mod+b      → Browser"
	echo ""
}

main "$@"
