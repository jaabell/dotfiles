-- Personal keybinding overrides for quattro.

-- Unbind defaults that conflict with my custom bindings.
hl.unbind("SUPER + O")
hl.unbind("SUPER + C")
hl.unbind("SUPER + X")
hl.unbind("SUPER + A")
hl.unbind("SUPER + SHIFT + A")
hl.unbind("SUPER + SHIFT + G")
hl.unbind("SUPER + SHIFT + ALT + G")

-- App bindings
o.bind("SUPER + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + C", "Calendar", { webapp = "https://calendar.google.com/calendar/u/0/r?pli=1" })
o.bind("CTRL + E", "Email", { webapp = "https://www.gmail.com/" })
o.bind("SUPER + E", "Email", { webapp = "https://www.gmail.com/" })
o.bind("SUPER + A", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + ALT + A", "ChatGPT Temporary", { webapp = "https://chatgpt.com/?temporary-chat=true" })
o.bind("SUPER + SHIFT + A", "Claude", { webapp = "https://claude.ai/" })
o.bind("SUPER + X", "X", { webapp = "https://x.com/" })
o.bind("SUPER + SHIFT + X", "X Post", { webapp = "https://x.com/compose/post" })
o.bind("SUPER + Y", "YouTube", { webapp = "https://youtube.com/" })
o.bind("SUPER + SHIFT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/" })
o.bind("SUPER + SHIFT + ALT + G", "Telegram", { webapp = "https://web.telegram.org/" })
o.bind("SUPER + SHIFT + CTRL + G", "Google Messages", { webapp = "https://messages.google.com/web/conversations" })
o.bind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/" })
o.bind("SUPER + SHIFT + W", "Typora", "uwsm-app -- typora --enable-wayland-ime")
o.bind("SUPER + SHIFT + SLASH", "Passwords", "uwsm-app -- 1password")
o.bind("SUPER + D", "Docker", "omarchy-launch-tui lazydocker")
o.bind("SUPER + SHIFT + T", "Activity", "omarchy-launch-tui btop")

-- VNC submap is defined in vnc-submap.conf (sourced by hyprland.conf)
-- because the Lua API doesn't support submaps.
