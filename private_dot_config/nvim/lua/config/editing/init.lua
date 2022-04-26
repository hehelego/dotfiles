local function L(mod)
	return require("config.editing." .. mod)
end

L("hop")
L("comment")
L("indent-blankline")
