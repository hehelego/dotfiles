local function L(mod)
	return require("keymaps.tools." .. mod)
end

L("which-key")
L("telescope")
L("nvim-tree")
L("aerial")
