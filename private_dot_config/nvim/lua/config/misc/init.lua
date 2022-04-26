local function L(mod)
	return require("config.misc." .. mod)
end

L("markdown-preview")
L("gitsigns")
