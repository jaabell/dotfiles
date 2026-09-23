-- Personal keybinding overrides for quattro.

-- Unbind defaults that conflict with my custom bindings.
hl.unbind("SUPER + O")
hl.unbind("SUPER + X")
hl.unbind("SUPER + A")
hl.unbind("SUPER + SHIFT + A")
hl.unbind("SUPER + SHIFT + C")
hl.unbind("SUPER + SHIFT + G")
hl.unbind("SUPER + SHIFT + ALT + G")
hl.unbind("SUPER + SHIFT + S") -- was Google Maps; repurposed for the screen-draw overlay
hl.unbind("SUPER + SHIFT + D") -- redundant Docker dup (SUPER+D already opens it); reused for blackboard

-- App bindings
o.bind("SUPER + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + B", "Floating browser", os.getenv("HOME") .. "/.config/hypr/floating-browser.sh")
-- Steady-state webapp binds use `launch` (not `webapp`) together with `focus`:
-- `{ webapp = url, focus = ... }` ignores the focus pattern entirely and
-- matches on the bind's description instead (see o.launch_webapp_sole), which
-- silently fails to focus anything whose window title/class doesn't contain
-- the description text (e.g. "Email" never matches a Gmail window). Pairing
-- `launch = "omarchy-launch-webapp <url>"` with an explicit `focus` regex
-- goes through o.launch_sole, which actually honors that pattern. Composer-
-- style binds (temp chat, new post) are deliberately left without focus -
-- they're meant to open fresh each time.
o.bind("SUPER + SHIFT + C", "Calendar", {
  launch = "omarchy-launch-webapp https://calendar.google.com/calendar/u/0/r?pli=1",
  focus = "calendar\\.google\\.com",
})
o.bind("SUPER + E", "Email", {
  launch = "omarchy-launch-webapp https://www.gmail.com/",
  focus = "www\\.gmail\\.com",
})
o.bind("SUPER + A", "ChatGPT", { launch = "omarchy-launch-webapp https://chatgpt.com", focus = "chatgpt\\.com" })
o.bind("SUPER + ALT + A", "ChatGPT Temporary", { webapp = "https://chatgpt.com/?temporary-chat=true" })
o.bind("SUPER + SHIFT + A", "Claude", { launch = "omarchy-launch-webapp https://claude.ai/", focus = "claude\\.ai" })
o.bind("SUPER + X", "X", { launch = "omarchy-launch-webapp https://x.com/", focus = "x\\.com" })
o.bind("SUPER + SHIFT + X", "X Post", { webapp = "https://x.com/compose/post" })
o.bind("SUPER + Y", "YouTube", { launch = "omarchy-launch-webapp https://youtube.com/", focus = "youtube\\.com" })
o.bind("SUPER + SHIFT + G", "WhatsApp", { launch = "omarchy-launch-webapp https://web.whatsapp.com/", focus = "whatsapp\\.com" })
o.bind("SUPER + SHIFT + ALT + G", "Telegram", { launch = "omarchy-launch-webapp https://web.telegram.org/", focus = "telegram\\.org" })
o.bind("SUPER + SHIFT + CTRL + G", "Google Messages", {
  launch = "omarchy-launch-webapp https://messages.google.com/web/conversations",
  focus = "messages\\.google\\.com",
})
o.bind("SUPER + SHIFT + P", "Google Photos", {
  launch = "omarchy-launch-webapp https://photos.google.com/",
  focus = "photos\\.google\\.com",
})
o.bind("SUPER + SHIFT + W", "Typora", "uwsm-app -- typora --enable-wayland-ime")
o.bind("SUPER + SHIFT + SLASH", "Passwords", "uwsm-app -- 1password")
o.bind("SUPER + D", "Docker", "omarchy-launch-tui lazydocker")
o.bind("SUPER + SHIFT + T", "Activity", "omarchy-launch-tui btop")

-- VNC submap: SUPER+SHIFT+V enters passthrough mode (red border cue).
local vnc_script = os.getenv("HOME") .. "/.config/hypr/vnc-toggle.sh"
hl.define_submap("vnc", function()
    hl.bind("SUPER + SHIFT + V", hl.dsp.submap("reset"), { description = "Exit VNC mode" })
    hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd(vnc_script), { description = "VNC exit notification" })
end)
hl.bind("SUPER + SHIFT + V", hl.dsp.submap("vnc"), { description = "Enter VNC mode" })
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd(vnc_script), { description = "VNC enter notification" })

-- Screen-draw overlay (wayscriber) - toggle on/off like the scratchpad.
-- Daemon runs via `systemctl --user enable --now wayscriber.service`.
--   SUPER+SHIFT+S      transparent overlay over the live screen
--   SUPER+SHIFT+D      opaque blackboard canvas
--   SUPER+SHIFT+PRINT  freeze the current screen as a still image and draw on it
-- Each combo toggles: press once to show (on that board), again to hide.
-- In-overlay: drag = pen, Shift+drag = line, Ctrl+drag = rect, Ctrl+Shift+drag = arrow,
-- T = text, R/G/B/Y/O/P/W/K = colors, Ctrl+Z/Y = undo/redo, scroll or +/- = size,
-- Ctrl+W / Ctrl+B / Ctrl+Shift+T = switch to whiteboard / blackboard / transparent, F1 = help.
-- Note: --no-resume-session on blackboard/freeze is required - otherwise the saved
-- session restores the transparent board and overrides --mode. It also means those
-- two open a fresh canvas each time (like wiping a blackboard); the transparent
-- overlay still persists its annotations between toggles.
if o.cmd_present("wayscriber") then
  o.bind("SUPER + SHIFT + S", "Toggle screen-draw overlay", "wayscriber --daemon-toggle --mode transparent")
  o.bind("SUPER + SHIFT + D", "Toggle blackboard draw", "wayscriber --daemon-toggle --mode blackboard --no-resume-session")
  o.bind("SUPER + SHIFT + PRINT", "Toggle freeze-frame draw", "wayscriber --daemon-toggle --freeze --no-resume-session")
end

-- Voice dictation (voxtype) - Spanish with Shift+F9
if o.cmd_present("voxtype") then
  o.bind("SHIFT + F9", "Start dictation (Spanish, push-to-talk)", "voxtype record start --profile spanish")
  o.bind("SHIFT + F9", "Stop dictation (Spanish, push-to-talk)", "voxtype record stop", { release = true })
end
