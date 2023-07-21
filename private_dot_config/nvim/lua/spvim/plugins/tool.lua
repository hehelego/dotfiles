return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"jvgrootveld/telescope-zoxide",
		},
		cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
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
			telescope.load_extension("aerial")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
		config = function()
			local nvim_tree = require("nvim-tree")
			local on_attach = require("spvim.maps_cmds.nvim-tree")

			local opts = {
				sync_root_with_cwd = true,
				on_attach = on_attach,
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						glyphs = {
							git = {
								untracked = "",
								unstaged = "󰄱",
								staged = "",
								ignored = "",
								unmerged = "",
								renamed = "󰁕",
								deleted = "",
							},
						},
					},
				},
				system_open = {
					cmd = "xdg-open",
					args = {},
				},
				diagnostics = {
					enable = true,
				},
				trash = {
					cmd = "trash",
				},
			}
			nvim_tree.setup(opts)
		end,
	},
	{
		"stevearc/aerial.nvim",
		cmd = {
			"AerialToggle",
			"AerialOpen",
			"AerialOpenAll",
			"AerialClose",
			"AerialCloseAll",
			"AerialInfo",
		},
		opts = {
			backends = { "markdown", "man", "lsp", "treesitter" },
			layout = {
				placement = "edge", -- open aerial at the far right/left of the editor
			},
			filter_kind = false, -- display all symbols
			highlight_on_hover = true, -- Highlight the symbol in the source buffer when cursor is in the aerial win
			show_guides = true, -- Show box drawing characters for the tree hierarchy
		},
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "folke/trouble.nvim",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		cmd = { "TodoTrouble", "TodoLocList", "TodoQuickFix", "TodoTelescope" },
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		opts = {
			signs = {
				add = {
					text = "+",
				},
				change = {
					text = "~",
				},
				delete = {
					text = "_",
				},
				topdelete = {
					text = "‾",
				},
				changedelete = {
					text = "~",
				},
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = "Neogit",
		config = true,
	},
}
