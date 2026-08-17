#!/bin/bash
# Toggle VNC passthrough mode with visual cues.
STATE_FILE="/tmp/vnc-mode"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hyprctl eval 'hl.dsp.submap("reset")'
    hyprctl keyword general:col.active_border "rgba(33ccffee)"
    notify-send -u low -t 2000 "VNC Mode" "OFF"
else
    touch "$STATE_FILE"
    hyprctl eval 'hl.dsp.submap("vnc")'
    hyprctl keyword general:col.active_border "rgba(ff4444ee)"
    notify-send -u critical -t 0 "VNC Mode" "ON - All keys pass through to VNC"
fi
