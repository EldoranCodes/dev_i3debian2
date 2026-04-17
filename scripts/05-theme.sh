#!/usr/bin/env bash
# ================================================
# Module 05: Apply Purple Theme
# ================================================

set -e

echo -e "\033[0;35m[05/05]\033[0m Applying purple theme..."

# Color variables (from parent)
PURPLE_BG="#2e2640"
PURPLE_BG_ALT="#5d4b73"
PURPLE_FG="#e8e3c9"
PURPLE_ACCENT="#8fa7c4"
PURPLE_SECONDARY="#c284a4"
PURPLE_BINDING="#c99ad1"

# ============================================
# Neovim colorscheme
# ============================================
cat >"$HOME/.local/share/nvim/lua/colors/purple.lua" <<'NVIMCONF'
-- Purple Theme for Neovim
local colors = {
  bg = "#261f35",
  bg_alt = "#3d314f",
  fg = "#e8e3c9",
  primary = "#8fa7c4",
  secondary = "#c284a4",
  alert = "#c284a4",
  disabled = "#8fa7c4",
  binding_mode = "#c99ad1",
  visual = "#5c4170",
}

local hl = vim.api.nvim_set_hl

hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg })
hl(0, "FloatBorder", { fg = colors.bg_alt, bg = colors.bg })
hl(0, "CursorLine", { bg = colors.bg_alt })
hl(0, "CursorLineNr", { fg = colors.primary, bold = true })
hl(0, "Comment", { fg = colors.disabled, italic = true })
hl(0, "Keyword", { fg = colors.primary, bold = true })
hl(0, "Function", { fg = colors.primary })
hl(0, "String", { fg = colors.secondary })
hl(0, "Error", { fg = colors.alert, bold = true })
hl(0, "Search", { bg = colors.binding_mode, fg = colors.bg })
hl(0, "Visual", { bg = colors.visual })
hl(0, "LineNr", { fg = colors.disabled })
hl(0, "StatusLine", { fg = colors.fg, bg = colors.bg_alt })
hl(0, "StatusLineNC", { fg = colors.disabled, bg = colors.bg })
hl(0, "VertSplit", { fg = colors.bg_alt, bg = colors.bg })
hl(0, "Pmenu", { bg = colors.bg_alt, fg = colors.fg })
hl(0, "PmenuSel", { bg = colors.primary, fg = colors.bg })
hl(0, "TelescopeNormal", { bg = colors.bg })
hl(0, "TelescopeSelection", { bg = colors.visual, fg = colors.fg, bold = true })
hl(0, "TelescopeMatching", { fg = colors.primary, bold = true })
NVIMCONF
echo "  Applied neovim colorscheme"

# ============================================
# GTK theme (create settings file)
# ============================================
mkdir -p "$HOME/.config/gtk-3.0"
cat >"$HOME/.config/gtk-3.0/settings.ini" <<'GTKCONF'
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=JetBrains Mono 10
gtk-cursor-theme-name=Adwaita
GTKCONF
echo "  Applied GTK settings"

# ============================================
# Xresources for stterm
# ============================================
cat >"$HOME/.Xresources" <<'XRESCONF'
! Purple Theme Xresources
*.background: #2e2640
*.foreground: #e8e3c9
*.color0: #4b3b63
*.color1: #c284a4
*.color2: #8fa7c4
*.color3: #c284a4
*.color4: #8fa7c4
*.color5: #c99ad1
*.color6: #c284a4
*.color7: #e8e3c9
*.color8: #8fa7c4
*.color9: #c284a4
*.color10: #8fa7c4
*.color11: #c284a4
*.color12: #8fa7c4
*.color13: #c99ad1
*.color14: #c284a4
*.color15: #e8e3c9

! Terminal font
*.font: JetBrains Mono:size=10
XRESCONF

# Apply Xresources
xrdb -merge "$HOME/.Xresources" 2>/dev/null || true
echo "  Applied Xresources"

# ============================================
# LightDM greeter theme
# ============================================
if [[ -f /etc/lightdm/lightdm-gtk-greeter.conf ]]; then
	$SUDO tee /etc/lightdm/lightdm-gtk-greeter.conf >/dev/null <<'LIGHTCONF'
[greeter]
theme-name = Adwaita-dark
icon-theme-name = Papirus-Dark
font-name = JetBrains Mono 10
background = #2e2640
LIGHTCONF
	echo "  Applied LightDM greeter theme"
fi

# ============================================
# Create symbolic link for purple theme
# ============================================
cat >"$HOME/.config/rofi/config.rasi" <<'ROFILNK'
@import "purple-theme.rasi"
ROFILNK

# Reload i3 config
if command -v i3-msg &>/dev/null; then
	i3-msg reload 2>/dev/null || true
fi

echo -e "\033[0;32m[OK]\033[0m Purple theme applied"
