-- Look and feel overrides.

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 3,
	},
})

-- Fast workspace transitions.
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "quick" })
