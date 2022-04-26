-- See <https://github.com/nvim-telescope/telescope.nvim>
-- See <https://github.com/nvim-telescope/telescope-fzf-native.nvim>

local telescope = require("telescope")
local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")
telescope.setup({
	defaults = {
		mappings = {
			n = {
				["<M-p>"] = layout.toggle_preview,
				["<M-/>"] = actions.which_key,
				["K"] = actions.move_to_top,
				["J"] = actions.move_to_bottom,
				["<CR>"] = actions.select_default,
				["s"] = actions.select_horizontal,
				["v"] = actions.select_vertical,
				["t"] = actions.select_tab,
				["q"] = actions.close,
			},
			i = {
				["<M-p>"] = layout.toggle_preview,
				["<M-/>"] = actions.which_key,
				["<M-j>"] = actions.move_selection_next,
				["<M-k>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "file", "--exclude", ".git", "--strip-cwd-prefix" },
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("zoxide")
