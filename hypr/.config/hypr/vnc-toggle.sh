#!/bin/bash
# Toggle VNC passthrough mode with red border visual cue.
STATE_FILE="/tmp/vnc-mode"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hyprctl dispatch submap reset
    hyprctl keyword general:col.active_border "rgba(33ccffee)"
else
    touch "$STATE_FILE"
    hyprctl dispatch submap vnc
    hyprctl keyword general:col.active_border "rgba(ff4444ee)"
fi
