local function L(mod)
	return require("keymaps.ui." .. mod)
end

L("colorscheme")
L("dashboard")
L("bufferline")
L("lualine")
L("colorizer")
