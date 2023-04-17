return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = {
					-- When true, <Esc> will close the modal
					insert_only = false,
					-- When true, input will start in insert mode.
					start_in_insert = true,
					-- allow wrapping
					win_options = {
						wrap = false,
					},
				},
			})
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				show_end_of_buffer = false,
				term_colors = true,
				integrations = {
					aerial = true,
					cmp = true,
					dashboard = true,
					gitsigns = true,
					leap = true,
					lsp_trouble = false,
					nvimtree = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					ts_rainbow = true,
					ts_rainbow2 = true,
					which_key = true,
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
				},
				extensions = {
					"aerial",
					"fzf",
					"lazy",
					"man",
					"nvim-dap-ui",
					"nvim-tree",
					"quickfix",
					"toggleterm",
					"trouble",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				tabline = {
					lualine_a = {
						{
							"buffers",
							show_filename_only = false,
							hide_filename_extension = false,
							show_modified_status = true,
						},
					},
					lualine_z = { "tabs" },
				},
				winbar = {
					lualine_c = { "filename" },
				},
				inactive_winbar = {
					lualine_c = { "filename" },
				},
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			local startify = require("alpha.themes.startify")
			startify.section.top_buttons.val = {
				startify.button("e", "new empty file", "<cmd>enew<cr>"),
				startify.button("f", "find file", "<cmd>Telescope find_files<cr>"),
				startify.button("h", "history files", "<cmd>Telescope oldfiles<cr>"),
				startify.button("g", "grep string", "<cmd>Telescope live_grep<cr>"),
				startify.button("G", "neogit", "<cmd>Neogit<cr>"),
				startify.button("z", "zoxide chdir", "<cmd>Telescope zoxide list<cr>"),
				startify.button(".", "Edit $MYVIMRC", "<cmd>edit $MYVIMRC<cr> <cmd>cd %:h<cr>"),
				startify.button("?", "Search helptags", "<cmd>Telescope help_tags<cr>"),
			}
			require("alpha").setup(startify.config)
		end,
	},
}
