local function L(mod)
	return require("keymaps.editing." .. mod)
end

L("hop")
L("comment")
