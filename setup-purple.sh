#!/usr/bin/env bash
# ================================================
# Debian i3wm Purple Theme - Post Install Script
# ================================================
# Run this ON the VM after Debian base install

set -e

PURPLE_BG="#2e2640"
PURPLE_BG_ALT="#5d4b73"
PURPLE_FG="#e8e3c9"
PURPLE_ACCENT="#8fa7c4"
PURPLE_SECONDARY="#c284a4"
PURPLE_BINDING="#c99ad1"

echo -e "\033[0;35m"
echo "  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗"
echo "  ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║██╔════╝"
echo "  ██████╔╝██████╔╝██╔██╗ ██║███████╗██║██║  ███╗"
echo "  ██╔═══╝ ██╔══██╗██║╚██╗██║╚════██║██║██║   ██║"
echo "  ██║     ██║  ██║██║ ╚████║███████║██║╚██████╔╝"
echo "  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝"
echo "  Purple Theme Installer"
echo -e "\033[0m"

# Check if running as root or with sudo
if [[ $EUID -ne 0 ]]; then
  if command -v sudo &>/dev/null; then
    SUDO=sudo
  else
    echo "Please run as root or install sudo"
    exit 1
  fi
else
  SUDO=""
fi

echo ">>> Updating package lists..."
$SUDO apt update

echo ">>> Installing core packages..."
$SUDO apt install -y \
  i3 xorg xinit lightdm lightdm-gtk-greeter \
  polybar picom rofi \
  stterm neovim firefox-esr \
  brightnessctl pulsemixer acpi \
  fonts-jetbrains-mono fonts-font-awesome \
  pulseaudio pavucontrol \
  git curl wget htop btop fzf zoxide eza \
  blueman network-manager-gnome \
  xss-lock feh

echo ">>> Creating config directories..."
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar/scripts
mkdir -p ~/.config/picom
mkdir -p ~/.config/rofi
mkdir -p ~/.local/share/nvim/lua/colors

echo ">>> Writing i3 config..."
cat >~/.config/i3/config <<'I3CONF'

gaps inner 2
gaps outer 2
smart_gaps on
smart_borders on

default_border pixel 2
default_floating_border pixel 2

set $mod Mod4
font pango:JetBrains Mono 10

exec --no-startup-id dex --autostart --environment i3
exec --no-startup-id picom --config ~/.config/picom/picom.conf
exec_always --no-startup-id polybar main
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
exec --no-startup-id nm-applet

set $refresh_i3status killall -SIGUSR1 i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status

floating_modifier $mod
bindsym $mod+return exec st
bindsym $mod+t exec st
bindsym $mod+e exec thunar
bindsym $mod+q kill
bindsym $mod+a exec rofi -show drun
bindsym $mod+b exec firefox-esr
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'"

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

bindsym $mod+f fullscreen toggle
bindsym $mod+Shift+space floating toggle

bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10

bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
# ... add more as needed

bindsym $mod+Shift+r restart
I3CONF

echo ">>> Writing polybar config..."
cat >~/.config/polybar/config.ini <<'POLYCONF'
[colors]
background        = #2e2640
background-alt    = #5d4b73
foreground        = #e8e3c9
primary           = #8fa7c4
secondary         = #c284a4
alert             = #c284a4
disabled          = #8fa7c4
binding_mode      = #c99ad1

[bar/main]
width = 100%
height = 32pt
radius = 0
enable-ipc = true
background = ${colors.background}
foreground = ${colors.foreground}
line-size = 0pt
border-size = 0
padding-left = 0
padding-right = 2
module-margin = 1
separator = |
separator-foreground = ${colors.disabled}
font-0 = "JetBrainsMono Nerd Font:pixelsize=12"
font-1 = "JetBrains Mono:pixelsize=12"
modules-left = xworkspaces xwindow
modules-center = date
modules-right = pulseaudio memory cpu systray power-menu
cursor-click = pointer

[module/xworkspaces]
type = internal/xworkspaces
format-prefix = %{T1}  %{T-}
label-active = %name%
label-active-background = ${colors.background-alt}
label-active-underline = ${colors.primary}
label-occupied = %name%
label-empty = %name%
label-empty-foreground = ${colors.disabled}

[module/xwindow]
type = internal/xwindow
label = %class%

[module/pulseaudio]
type = internal/pulseaudio
format-volume-prefix = "VOL "
format-volume-prefix-foreground = ${colors.primary}
label-volume = %percentage%%
label-muted = muted
label-muted-foreground = ${colors.disabled}

[module/memory]
type = internal/memory
interval = 2
format-prefix = " "
format-prefix-foreground = ${colors.primary}
label = %percentage_used:2%%

[module/cpu]
type = internal/cpu
interval = 2
format-prefix = "  "
format-prefix-foreground = ${colors.primary}
label = %percentage:2%%

[module/date]
type = internal/date
interval = 1
date = %I:%M
date-alt = %Y-%m-%d %H:%M:%S
label = %date%
label-foreground = ${colors.foreground}

[module/systray]
type = internal/tray
format-margin = 8pt
tray-spacing = 16pt

[module/power-menu]
type = custom/text
content = "⏻"
click-left = ~/.config/polybar/scripts/rofi-power.sh

[settings]
screenchange-reload = true
pseudo-transparency = true
POLYCONF

echo ">>> Writing picom config..."
cat >~/.config/picom/picom.conf <<'PICOMCONF'
backend = "xrender";
vsync = true;
fading = true;
fade-in-step = 0.02;
fade-out-step = 0.02;
fade-delta = 5;
no-fading-openclose = false;
shadow = false;
corner-radius = 8;
rounded-corners-exclude = [
  "class_g = 'i3-frame'",
  "window_type = 'dock'",
  "window_type = 'desktop'"
];
opacity-rule = [
  "90:class_g *= 'i3-frame'"
];
PICOMCONF

echo ">>> Writing rofi purple theme..."
cat >~/.config/rofi/purple-theme.rasi <<'ROFICONF'
* {
    bg:          #2e2640;
    bg-dark:     #241d33;
    fg:          #e8e3c9;
    accent:      #8fa7c4;
}

window {
    background-color: @bg;
    width: 45%;
    border: 2px;
    border-color: @accent;
    border-radius: 12px;
    padding: 20px;
}

mainbox { children: [inputbar, listview]; }
inputbar { padding: 6px 0; }
prompt { text-color: @accent; padding: 4px 6px; }
entry { text-color: @fg; padding: 4px 6px; }
listview { padding: 8px 0; spacing: 6px; fixed-height: true; }
element { background-color: @bg-dark; text-color: @fg; padding: 6px 12px; }
element selected { background-color: @accent; text-color: @bg; }
element urgent { background-color: #c284a4; text-color: @bg; }
ROFICONF

echo ">>> Writing kitty colorscheme..."
cat >~/.config/kitty/purple-colorscheme.conf <<'KITTYCONF'
background      #261f35
foreground      #e8e3c9
cursor          #8fa7c4
selection_background #4b3b63

color0  #4b3b63
color1  #c284a4
color2  #8fa7c4
color3  #c284a4
color4  #8fa7c4
color5  #c99ad1
color6  #c284a4
color7  #e8e3c9
color8  #8fa7c4
color9  #c284a4
color10 #8fa7c4
color11 #c284a4
color12 #8fa7c4
color13 #c99ad1
color14 #c284a4
color15 #e8e3c9

bold_color #e8e3c9
KITTYCONF

echo ">>> Writing polybar scripts..."
mkdir -p ~/.config/polybar/scripts
cat >~/.config/polybar/scripts/rofi-power.sh <<'SCRIPT'
#!/usr/bin/env bash
rofi -theme ~/.config/rofi/purple-theme.rasi -show power-menu -modi power-menu
SCRIPT
chmod +x ~/.config/polybar/scripts/rofi-power.sh

cat >~/.config/polybar/scripts/brightnessctl.sh <<'SCRIPT'
#!/usr/bin/env bash
brightnessctl get
SCRIPT
chmod +x ~/.config/polybar/scripts/brightnessctl.sh

echo ">>> Writing Neovim colorscheme..."
cat >~/.local/share/nvim/lua/colors/purple.lua <<'NVIMCONF'
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
NVIMCONF

echo ">>> Writing ~/.xinitrc..."
cat >~/.xinitrc <<'XINITRC'
#!/bin/sh
exec i3
XINITRC
chmod +x ~/.xinitrc

echo ""
echo -e "\033[0;32m✓ Purple Theme Installation Complete!\033[0m"
echo ""
echo "Next steps:"
echo "  1. Reboot or logout"
echo "  2. Select 'i3' at login (lightdm)"
echo "  3. Or run: startx"
echo ""
echo "Keybinds:"
echo "  Mod+t = Terminal"
echo "  Mod+a = Rofi (apps)"
echo "  Mod+e = File manager"
echo ""
