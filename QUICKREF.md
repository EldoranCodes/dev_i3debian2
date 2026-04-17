# ================================================
# Debian i3wm Purple Theme - Quick Reference
# ================================================

## Color Palette

| Variable | Hex | Usage |
|----------|-----|-------|
| `bg` | `#2e2640` | Main background |
| `bg-alt` | `#5d4b73` | Secondary/surface |
| `fg` | `#e8e3c9` | Text/foreground |
| `primary` | `#8fa7c4` | Soft blue accent |
| `secondary` | `#c284a4` | Muted rose/pink |
| `binding_mode` | `#c99ad1` | Light purple |

## Files

| File | Purpose |
|------|---------|
| `install.sh` | Main installer (run this) |
| `scripts/*.sh` | Modular install scripts |
| `README.md` | Full documentation |

## Quick Install

```bash
# On fresh Debian VM:
chmod +x install.sh scripts/*.sh
./install.sh
```

## Transfer to VM

```bash
# Option 1: Git clone
git clone <repo-url>
cd i3debianVmSetup
./install.sh

# Option 2: HTTP server (host)
# Host:
python3 -m http.server 8000
# VM:
curl -LO http://<host-ip>:8000/install.sh
curl -LO http://<host-ip>:8000/scripts/01-update.sh
curl -LO http://<host-ip>:8000/scripts/02-mirror.sh
curl -LO http://<host-ip>:8000/scripts/03-packages.sh
curl -LO http://<host-ip>:8000/scripts/04-configs.sh
curl -LO http://<host-ip>:8000/scripts/05-theme.sh

# Option 3: SCP
scp -P 2222 -r ~/aichat/i3debianVmSetup/* user@localhost:~/
```

## i3 Keybinds

| Key | Action |
|-----|--------|
| `Mod+Enter` | Terminal (st) |
| `Mod+t` | Terminal (st) |
| `Mod+e` | File Manager |
| `Mod+a` | Rofi App Launcher |
| `Mod+b` | Browser (firefox) |
| `Mod+q` | Close window |
| `Mod+Space` | Toggle Float |
| `Mod+Shift+e` | Exit |
| `Mod+Shift+r` | Restart i3 |
| `Mod+1-0` | Workspace 1-10 |

## Common Commands

```bash
polybar main &           # Start polybar manually
picom &                 # Start compositor
pavucontrol &           # Audio mixer
nm-applet &             # Network manager
rofi -show drun         # App launcher
```
