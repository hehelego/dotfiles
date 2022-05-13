local wezterm = require("wezterm")

local config = {}
local function update(conf)
	for k, v in pairs(conf) do
		config[k] = v
	end
end

update({
	-- try to connect with wayland protocol
	enable_wayland = true,
	exit_behavior = "CloseOnCleanExit",
})

update({
	dpi = 192.0,
	font_size = 12.0,
	font = wezterm.font_with_fallback({
		-- monospace font
		"Hack",
		"Noto Sans Mono",
		-- nerd fonts icons
		"Hack Nerd Font Mono",
		"Iosevka Nerd Font Mono",
		-- colorful emoji
		"Noto Color Emoji",
		-- CJK characters
		"Noto Sans CJK SC",
	}),
	-- freetype font rendering settings
	font_rasterizer = "FreeType",
	freetype_load_flags = "DEFAULT",
	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",
})

local scheme_origin = "nord"
local scheme_nobg = wezterm.get_builtin_color_schemes()[scheme_origin]
scheme_nobg.background = "rgba(10%, 10%, 10%, 80%)"
update({
	color_schemes = {
		["scheme_nobg"] = scheme_nobg,
	},
	color_scheme = "scheme_nobg",
	-- set the opacity
	text_background_opacity = 1.0,
	window_background_opacity = 1.0,
	-- cursor color = reversed text color
	force_reverse_video_cursor = true,
})

update({
	-- tab bar
	enable_tab_bar = true,
	tab_max_width = 20,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	-- no scroll bar
	enable_scroll_bar = false,
	-- geometry padding
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
})

update({
	disable_default_key_bindings = false,
	mouse_bindings = {
		-- Bind 'Up' event of CTRL-Click to open hyperlinks
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
		-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = "Nop",
		},
	},
})

return config
