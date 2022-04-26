local function L(mod)
	return require("config." .. mod)
end

L("common")
L("ui")
L("tools")
L("editing")
L("langs")
L("misc")
