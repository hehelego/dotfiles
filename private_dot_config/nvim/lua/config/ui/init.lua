local function L(mod)
	return require("config.ui." .. mod)
end

L("devicons")
L("colorscheme")
L("dashboard")
L("bufferline")
L("lualine")
L("colorizer")
