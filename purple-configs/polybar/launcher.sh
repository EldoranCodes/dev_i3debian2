#!/bin/bash

# Kill already running instances
killall -q polybar

polybar main &

nm-applet &
