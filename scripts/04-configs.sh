#!/usr/bin/env bash
# ================================================
# Module 04: Create Config Files
# ================================================

set -e

echo -e "\033[0;35m[04/05]\033[0m Creating config files..."

# Color variables (from parent)
PURPLE_BG="#2e2640"
PURPLE_BG_ALT="#5d4b73"
PURPLE_FG="#e8e3c9"
PURPLE_ACCENT="#8fa7c4"
PURPLE_SECONDARY="#c284a4"
PURPLE_BINDING="#c99ad1"

# Create config directories
CONFIG_DIRS=(
	"$HOME/.config/i3"
	"$HOME/.config/polybar"
	"$HOME/.config/polybar/scripts"
	"$HOME/.config/picom"
	"$HOME/.config/rofi"
	"$HOME/.local/share/nvim/lua/colors"
)

for dir in "${CONFIG_DIRS[@]}"; do
	mkdir -p "$dir"
done
echo "  Config directories created"

# ============================================
# i3 config
# ============================================
cat >"$HOME/.config/i3/config" <<'I3CONF'
# i3 config - Purple Theme
# Mod key (Windows key)
set $mod Mod4

# Gaps
gaps inner 2
gaps outer 2
smart_gaps on
smart_borders on

# Borders
default_border pixel 2
default_floating_border pixel 2

# Font
font pango:JetBrains Mono 10

# Autostart
exec --no-startup-id dex --autostart --environment i3
exec --no-startup-id picom --config ~/.config/picom/picom.conf
exec_always --no-startup-id polybar main
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
exec --no-startup-id nm-applet

# Volume keys
set $refresh_i3status killall -SIGUSR1 i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status

# Keybinds
floating_modifier $mod
bindsym $mod+return exec st
bindsym $mod+t exec st
bindsym $mod+e exec thunar
bindsym $mod+q kill
bindsym $mod+a exec rofi -show drun
bindsym $mod+b exec firefox-esr
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'"

# Focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# Move
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# Fullscreen & Float
bindsym $mod+f fullscreen toggle
bindsym $mod+Shift+space floating toggle

# Workspaces
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
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5

# Reload & Restart
bindsym $mod+Shift+r restart
I3CONF
echo "  Created i3 config"

# ============================================
# Polybar config
# ============================================
cat >"$HOME/.config/polybar/config.ini" <<'POLYCONF'
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
separator = |
separator-foreground = ${colors.disabled}
font-0 = "JetBrainsMono Nerd Font:pixelsize=12"
font-1 = "JetBrains Mono:pixelsize=12"
modules-left = xworkspaces xwindow
modules-center = date
modules-right = pulseaudio memory cpu systray power-menu

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
format-prefix = " "
format-prefix-foreground = ${colors.primary}
label = %percentage_used:2%%

[module/cpu]
type = internal/cpu
interval = 2
format-prefix = " "
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
echo "  Created polybar config"

# ============================================
# Picom config
# ============================================
cat >"$HOME/.config/picom/picom.conf" <<'PICOMCONF'
backend = "xrender";
vsync = true;
fading = true;
fade-in-step = 0.02;
fade-out-step = 0.02;
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
echo "  Created picom config"

# ============================================
# Rofi purple theme
# ============================================
cat >"$HOME/.config/rofi/purple-theme.rasi" <<'ROFICONF'
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
echo "  Created rofi purple theme"

# ============================================
# Polybar scripts
# ============================================
cat >"$HOME/.config/polybar/scripts/rofi-power.sh" <<'SCRIPT'
#!/usr/bin/env bash
rofi -theme ~/.config/rofi/purple-theme.rasi -show power-menu -modi power-menu
SCRIPT
chmod +x "$HOME/.config/polybar/scripts/rofi-power.sh"

cat >"$HOME/.config/polybar/scripts/brightnessctl.sh" <<'SCRIPT'
#!/usr/bin/env bash
brightnessctl get
SCRIPT
chmod +x "$HOME/.config/polybar/scripts/brightnessctl.sh"
echo "  Created polybar scripts"

# ============================================
# xinitrc for startx
# ============================================
cat >"$HOME/.xinitrc" <<'XINITRC'
#!/bin/sh
exec i3
XINITRC
chmod +x "$HOME/.xinitrc"
echo "  Created .xinitrc"

echo -e "\033[0;32m[OK]\033[0m Config files created"
