#!/bin/bash

options=" Shutdown\n Reboot\n Logout\n Lock"

chosen="$(echo -e "$options" | rofi -dmenu -i -p 'Power' -lines 4 -font 'JetBrainsMono Nerd Font 12')"

case "$chosen" in
" Shutdown") systemctl poweroff ;;
" Reboot") systemctl reboot ;;
" Logout") i3-msg exit ;;
" Lock") i3lock ;;
esac
