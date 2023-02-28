local function L(mod)
	return require("config.editing." .. mod)
end

L("leap")
L("comment")
L("indent-blankline")
