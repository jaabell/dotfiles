-- Input configuration.

hl.config({
  input = {
    kb_layout = "latam",
    kb_options = "compose:caps",
    repeat_rate = 40,
    repeat_delay = 600,
    numlock_by_default = true,

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,
    },
  },
})

-- Terminal scroll speeds.
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })
