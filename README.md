# Debian i3wm Purple Theme - Installation Guide

## Overview

Modular installation script for Debian i3wm with purple theme.

**Purple Theme Colors:**
| Variable | Hex | Usage |
|----------|-----|-------|
| `bg` | `#2e2640` | Main background |
| `bg-alt` | `#5d4b73` | Secondary |
| `fg` | `#e8e3c9` | Text |
| `primary` | `#8fa7c4` | Accent |
| `secondary` | `#c284a4` | Muted rose |
| `binding_mode` | `#c99ad1` | Light purple |

---

## Quick Start (On Fresh Debian)

```bash
# 1. Get the setup files (see Transfer Options below)

# 2. Make scripts executable
chmod +x install.sh
chmod +x scripts/*.sh

# 3. Run installer (as root or with sudo)
./install.sh

# 4. Reboot and select i3 at login
sudo reboot
```

---

## Transfer Options

### Option 1: Git Clone (Recommended)
```bash
# Push to GitHub/GitLab first, then in VM:
git clone https://github.com/you/i3debianVmSetup.git
cd i3debianVmSetup
./install.sh
```

### Option 2: HTTP Server (Host)
```bash
# On HOST machine:
cd ~/aichat/i3debianVmSetup
python3 -m http.server 8000

# In VM (find host IP with 'ip a' or 'hostname -I'):
curl -LO http://192.168.x.x:8000/install.sh
curl -LO http://192.168.x.x:8000/scripts/01-update.sh
# ... or download all scripts

# Then:
chmod +x install.sh scripts/*.sh
./install.sh
```

### Option 3: SCP over SSH
```bash
# Enable SSH in VM first (during install or manually):
sudo systemctl enable ssh
sudo systemctl start ssh

# From host, VM redirects port 2222 to 22:
scp -P 2222 -r ~/aichat/i3debianVmSetup/* user@localhost:~/
```

### Option 4: USB Passthrough
1. virt-manager → VM → Add Hardware → USB Host Device
2. Mount USB in VM: `sudo mount /dev/sdb1 /mnt`
3. Copy files: `cp -r /mnt/i3debianVmSetup ~/`

### Option 5: Shared Folder (virt-manager)
1. VM Settings → Memory → Add Feature → VirtIO FS
2. Or use 9p virtio: `-fsdev local,id=shared,path=/path,security_model=none -device virtio-9p-pci,fsdev=shared,mount_tag=shared`
3. Mount in VM: `sudo mount -t 9p -o trans=virtio shared /mnt/shared`

---

## Script Structure

```
i3debianVmSetup/
├── install.sh           # Main installer (calls modules)
├── scripts/
│   ├── 01-update.sh     # Update apt
│   ├── 02-mirror.sh     # Philippine mirrors
│   ├── 03-packages.sh   # Install packages
│   ├── 04-configs.sh    # Create configs
│   └── 05-theme.sh      # Apply purple theme
└── README.md
```

---

## Run Steps

### Automated (Recommended)
```bash
./install.sh
```

### Manual (Step by Step)
```bash
# 1. Update
sudo bash scripts/01-update.sh

# 2. Set mirrors (optional, for PH)
sudo bash scripts/02-mirror.sh

# 3. Install packages
sudo bash scripts/03-packages.sh

# 4. Create configs
bash scripts/04-configs.sh

# 5. Apply theme
bash scripts/05-theme.sh
```

---

## Module Details

### 01-update.sh
Updates apt package lists.
```bash
$SUDO apt update -qq
```

---

### 02-mirror.sh
Configures Philippine mirrors for faster downloads.

**Mirrors used:**
- Primary: `mirror.cloudzen.tech/debian/`
- Fallback: `mirror.upb.edu.ph/debian/`

Backs up original `/etc/apt/sources.list` to `sources.list.bak`.

---

### 03-packages.sh
Installs all required packages:

| Category | Packages |
|----------|----------|
| Core | i3, xorg, xinit, lightdm, lightdm-gtk-greeter |
| UI | polybar, picom, rofi |
| Terminal | stterm, neovim |
| Browser | firefox-esr |
| Utilities | brightnessctl, pulsemixer, acpi |
| Fonts | fonts-jetbrains-mono, fonts-font-awesome |
| Audio | pulseaudio, pavucontrol |
| CLI | git, curl, wget, btop, fzf, zoxide, eza, yazi |
| Network | blueman, network-manager-gnome |
| Misc | xss-lock, feh |

---

### 04-configs.sh
Creates config files in `~/.config/`:

| File | Purpose |
|------|---------|
| `i3/config` | Window manager settings |
| `polybar/config.ini` | Status bar |
| `picom/picom.conf` | Compositor |
| `rofi/purple-theme.rasi` | App launcher theme |
| `polybar/scripts/rofi-power.sh` | Power menu |
| `.xinitrc` | Startx entry |

---

### 05-theme.sh
Applies purple theme to:

| Component | File |
|-----------|------|
| Neovim | `~/.local/share/nvim/lua/colors/purple.lua` |
| GTK | `~/.config/gtk-3.0/settings.ini` |
| Xresources | `~/.Xresources` (for stterm) |
| LightDM | `/etc/lightdm/lightdm-gtk-greeter.conf` |

---

## Keybinds

| Key | Action |
|-----|--------|
| `Mod+Enter` | Terminal (st) |
| `Mod+t` | Terminal (st) |
| `Mod+e` | File manager (thunar) |
| `Mod+a` | Rofi app launcher |
| `Mod+b` | Browser (firefox) |
| `Mod+q` | Close window |
| `Mod+Shift+e` | Exit i3 |
| `Mod+Shift+r` | Restart i3 |
| `Mod+1-5` | Workspace 1-5 |
| `Mod+Space` | Toggle floating |
| `Mod+h/j/k/l` | Focus window |
| `Mod+Shift+h/j/k/l` | Move window |

---

## First Boot

1. Reboot or logout
2. Select **i3** at LightDM login
3. Done!

---

## Troubleshooting

**Black screen after login:**
```bash
# Press Ctrl+Alt+F2 to get TTY
cat ~/.xsession-errors
ls ~/.config/i3/
```

**Polybar not showing:**
```bash
polybar main &
```

**Picom not working:**
```bash
picom --config ~/.config/picom/picom.conf &
```

**Audio not working:**
```bash
pavucontrol &
```

**Mirror errors:**
```bash
# Restore original
sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list
sudo apt update
```

---

## Uninstall

```bash
# Remove configs
rm -rf ~/.config/i3 ~/.config/polybar ~/.config/picom ~/.config/rofi
rm -f ~/.xinitrc ~/.Xresources

# Restore original mirrors
sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list
sudo apt update
```
