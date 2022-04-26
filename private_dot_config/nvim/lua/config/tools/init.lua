local function L(mod)
	return require("config.tools." .. mod)
end

L("nvim-tree")
L("which-key")
L("telescope")
L("aerial")
L("trouble")
L("todo-comments")
