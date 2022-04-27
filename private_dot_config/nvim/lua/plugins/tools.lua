local function telescope_plugins(use)
	-- telescope.nvim fuzzy finder
	use("nvim-telescope/telescope.nvim")

	-- fzf algorithm backend for telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- change directory via zoxide
	use("jvgrootveld/telescope-zoxide")
end

local function tools_plugins(use)
	-- show possible keybindings in floating window
	use("folke/which-key.nvim")

	telescope_plugins(use)

	-- organize diagnostics, reference, implementation, definition
	use("folke/trouble.nvim")

	-- manage special comment markers (TODO,NOTE,FIXME)
	use("folke/todo-comments.nvim")

	-- file tree explorer
	use("kyazdani42/nvim-tree.lua")

	-- show code structure and symbol tree
	use("stevearc/aerial.nvim")
end
return tools_plugins