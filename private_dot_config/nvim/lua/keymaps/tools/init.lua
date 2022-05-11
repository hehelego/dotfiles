local function L(mod)
	return require("keymaps.tools." .. mod)
end

L("telescope")
L("nvim-tree")
L("aerial")
L("perfanno")
L("gitsigns")
