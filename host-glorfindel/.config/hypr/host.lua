-- glorfindel-specific settings (laptop).
--
-- Only the internal panel is declared here as a baseline. External displays
-- (mirror / extend / projector) change constantly and rarely match resolution,
-- so they are managed live via the Better Displays bar widget
-- (`omarchy display monitor`) and persisted to the local, untracked
-- ~/.config/hypr/monitors.lua, which loads after this file and wins.

hl.env("GDK_SCALE", "1")
hl.monitor({ output = "eDP-2", mode = "preferred", position = "auto", scale = 1 })
