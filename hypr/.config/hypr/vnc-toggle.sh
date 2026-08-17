#!/bin/bash
# Toggle VNC mode: visual cue (red border) + notification.
# Note: submaps don't work in quattro's Lua parser, so true key passthrough
# isn't available. Use this as a visual reminder that you're in VNC mode.
STATE_FILE="/tmp/vnc-mode"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hyprctl eval 'hl.config({ general = { col = { active_border = "rgba(33ccffee)" } } })'
    notify-send -u low -t 2000 "VNC Mode" "OFF"
else
    touch "$STATE_FILE"
    hyprctl eval 'hl.config({ general = { col = { active_border = "rgba(ff4444ee)" } } })'
    notify-send -u critical -t 0 "VNC Mode" "ON"
fi
