#!/bin/bash
# VNC mode visual cue: red border + notification.
STATE_FILE="/tmp/vnc-mode"
BORDER_FILE="/tmp/vnc-saved-border"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    if [ -f "$BORDER_FILE" ]; then
        BORDER=$(cat "$BORDER_FILE")
        rm "$BORDER_FILE"
    else
        BORDER="#9ba4bb"
    fi
    hyprctl eval "hl.config({ general = { col = { active_border = \"$BORDER\" } } })"
    notify-send -u low -t 2000 "VNC Mode" "OFF"
else
    hyprctl getoption general:col.active_border -j | python3 -c "
import sys, json
d = json.load(sys.stdin)
raw = d.get('gradient', '')
color = raw.split()[0]
# Convert AARRGGBB hex to rgba() format
if len(color) == 8 and all(c in '0123456789abcdef' for c in color.lower()):
    a = int(color[0:2], 16)
    r = int(color[2:4], 16)
    g = int(color[4:6], 16)
    b = int(color[6:8], 16)
    print(f'rgba({r},{g},{b},{a/255:.2f})')
else:
    print(color)
" > "$BORDER_FILE"
    touch "$STATE_FILE"
    hyprctl eval 'hl.config({ general = { col = { active_border = "rgba(255,0,0,0.93)" } } })'
    notify-send -u critical -t 0 "VNC Mode" "ON - All keys pass through to VNC"
fi
