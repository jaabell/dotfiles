-- Tensorcruncher-specific display and VNC controls.

hl.env("GDK_SCALE", "1")
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = 2 })

for workspace = 1, 5 do
  hl.workspace_rule({ workspace = tostring(workspace), monitor = "HDMI-A-1", persistent = true })
end

o.bind("SUPER + SHIFT + R", "VNC resolution toggle", os.getenv("HOME") .. "/.local/bin/vnc-res-toggle")
