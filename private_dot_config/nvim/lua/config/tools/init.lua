local function L(mod)
	return require("config.tools." .. mod)
end

L("which-key")
L("telescope")
L("nvim-tree")
L("aerial")
L("trouble")
L("todo-comments")
L("gitsigns")
