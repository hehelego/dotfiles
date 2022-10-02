local function telescope_plugins(use)
	-- telescope.nvim fuzzy finder
	use("nvim-telescope/telescope.nvim")

	-- fzf algorithm backend for telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- change directory via zoxide
	use("jvgrootveld/telescope-zoxide")
end

local function tools_plugins(use)
	telescope_plugins(use)

	-- show possible keybindings in floating window
	use("folke/which-key.nvim")

	-- organize diagnostics, reference, implementation, definition
	use("folke/trouble.nvim")

	-- manage special comment markers (TODO,NOTE,FIXME)
	use("folke/todo-comments.nvim")

	-- file tree explorer
	use("kyazdani42/nvim-tree.lua")

	-- show code structure and symbol tree
	use("stevearc/aerial.nvim")

	-- show git hunks on sign-column
	use("lewis6991/gitsigns.nvim")

	-- redirect command output into a buffer
	-- my own patched version
	use("hehelego/messages.nvim")
end
return tools_plugins
