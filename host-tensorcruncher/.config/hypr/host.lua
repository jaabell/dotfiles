-- Tensorcruncher-specific display, scratch monitor, and VNC controls.

hl.env("GDK_SCALE", "1")
hl.monitor({ output = "HDMI-A-2", mode = "3840x2160@60.00Hz", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-4", mode = "1920x1080@60.00Hz", position = "3840x0", scale = 1 })

for workspace = 1, 5 do
  hl.workspace_rule({ workspace = tostring(workspace), monitor = "HDMI-A-2", persistent = true })
end

-- Dedicated scratch workspace for OBS, screencasting, and temporary windows.
hl.workspace_rule({ workspace = "100", monitor = "DP-4", default = true, persistent = true })

o.bind("SUPER + SHIFT + R", "VNC resolution toggle", os.getenv("HOME") .. "/.local/bin/vnc-res-toggle")
