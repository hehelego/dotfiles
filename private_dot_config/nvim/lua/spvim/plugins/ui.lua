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
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.buttons.val = {
				dashboard.button("e", "  File explorer", "<cmd>NvimTreeFocus<cr>"),
				dashboard.button("f", "  Find files", "<cmd>Telescope find_files<cr>"),
				dashboard.button("F", "  Find files all", "<cmd>Telescope find_files hidden=true<cr>"),
				dashboard.button("h", "  File history", "<cmd>Telescope oldfiles<cr>"),
				dashboard.button("g", "  Search live grep", "<cmd>Telescope live_grep<cr>"),
				dashboard.button("z", "  Zoxide change dir", "<cmd>Telescope zoxide list<cr>"),
				dashboard.button(".", "  Edit neovim config", "<cmd>edit ~/.config/nvim/<cr>"),
				dashboard.button("l", "  Lazy.nvim plugin manager", "<cmd>Lazy<cr>"),
				dashboard.button("m", "󱧕  Mason.nvim package installer", "<cmd>Mason<cr>"),
				dashboard.button("?", "ﲉ  Search help pages", "<cmd>Telescope help_tags<cr>"),
				dashboard.button("q", "  Quit", "<cmd>quitall<cr>"),
			}
			require("alpha").setup(dashboard.opts)
		end,
	},
}
