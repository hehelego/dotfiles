local function L(mod)
	return require("keymaps." .. mod)
end

L("common")
L("ui")
L("tools")
L("editing")
L("langs")
