local term = require("wezterm")

local config = term.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	window_background_opacity = 0.87,
	default_cursor_style = "BlinkingUnderline",
	font = term.font("FiraCode Nerd Font Mono"),
	font_size = 14.0,
	color_scheme = "Ef-Bio",
	text_background_opacity = 1,
	window_padding = {
		left = 15,
		right = 15,
		top = 5,
		bottom = 5,
	},
	keys = {
		{
			key = "]",
			mods = "CTRL",
			action = term.action.SplitHorizontal,
		},
		{
			key = "[",
			mods = "CTRL",
			action = term.action.SplitVertical,
		},
		{
			key = "s",
			mods = "CTRL",
			action = term.action.PaneSelect,
		},
		{
			key = "q",
			mods = "CTRL",
			action = term.action.CloseCurrentPane { confirm = true },
		},
		{
			key = "H",
			mods = "OPT",
			action = term.action.AdjustPaneSize({ "Left", 1 }),
		},
		{
			key = "J",
			mods = "OPT",
			action = term.action.AdjustPaneSize({ "Down", 1 }),
		},
		{
			key = "K",
			mods = "OPT",
			action = term.action.AdjustPaneSize({ "Up", 1 }),
		},
		{
			key = "L",
			mods = "OPT",
			action = term.action.AdjustPaneSize({ "Right", 1 }),
		},
	},
}

return config
