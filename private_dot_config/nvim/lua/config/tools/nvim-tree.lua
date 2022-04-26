-- See <https://github.com/kyazdani42/nvim-tree.lua>
local nvim_tree = require("nvim-tree")
local action = require("nvim-tree.config").nvim_tree_callback

local opts = {
	update_cwd = true,
	view = {
		width = 30,
		height = 30,
		side = "left",
		preserve_window_proportions = false,
		mappings = {
			custom_only = true,
			list = {
				{ key = { "t", "<C-t>" }, cb = action("tabnew") },
				{ key = { "s", "<C-s>" }, cb = action("split") },
				{ key = { "v", "<C-v>" }, cb = action("vsplit") },
				{ key = { "q", "<C-q>" }, cb = action("close") },
				{ key = { "x", "<C-x>", "gx" }, cb = action("system_open") },
				{ key = "<Tab>", cb = action("edit") },
				{ key = "<CR>", cb = action("edit") },
				{ key = { "a", "A" }, cb = action("create") },
				{ key = "y", cb = action("copy") },
				{ key = "d", cb = action("cut") },
				{ key = "p", cb = action("paste") },
				{ key = "[", cb = action("dir_up") },
				{ key = "]", cb = action("cd") },
				{ key = "gy", cb = action("copy_path") },
				{ key = "gY", cb = action("copy_absolute_path") },
				{ key = "gd", cb = action("trash") },
				{ key = "gD", cb = action("remove") },
				{ key = "o", cb = action("toggle_file_info") },
				{ key = "r", cb = action("rename") },
				{ key = "R", cb = action("refresh") },
				{ key = "I", cb = action("toggle_git_ignored") },
				{ key = "H", cb = action("toggle_dotfiles") },
				{ key = "q", cb = action("close") },
				{ key = { "g?", "gh" }, cb = action("toggle_help") },
			},
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
		},
	},
	ignore_ft_on_setup = {},
	system_open = {
		cmd = "xdg-open",
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	diagnostic = {
		enable = true,
		show_on_dirs = true,
	},
}
nvim_tree.setup(opts)
