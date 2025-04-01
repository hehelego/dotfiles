return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
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
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
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

			vim.opt.background = "light"
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
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
		},
	},
	{
		"nvimdev/dashboard-nvim",
		lazy = false,
		opts = {
			theme = "doom",
			disable_move = true,
			shortcut_type = "number",
			config = {
				header = {},
				week_header = {
					enable = true,
				},
				footer = {},
				center = {
					-- { desc = "󰊳 Update", action = "Lazy update", key = "u" },
					-- { desc = "Files", action = "Telescope find_files", key = "f" },
					-- { desc = " Apps", action = "Telescope app", key = "a" },
					-- { desc = " dotfiles", action = "Telescope dotfiles", key = "d" },

					{ key = "e", desc = "  Explorer", action = "NvimTreeFocus" },
					{ key = "f", desc = "  Find files", action = "Telescope find_files" },
					{ key = "h", desc = "  History files", action = "Telescope oldfiles" },
					{ key = "g", desc = "󰑑  Grep string", action = "Telescope live_grep" },
					{ key = "G", desc = "  Neogit", action = "Neogit" },
					{ key = "z", desc = "  Zoxide change dir", action = "Telescope zoxide list" },
					{ key = "l", desc = "  Lazy.nvim plugin manager", action = "Lazy" },
					{ key = "m", desc = "󱧕  Mason.nvim package installer", action = "Mason" },
					{ key = "?", desc = "󰘥  Help tags", action = "Telescope help_tags" },
					{ key = "n", desc = "  enew", action = "enew" },
					{ key = "q", desc = "  Quit", action = "quitall" },
				},
			},
		},
	},
}
--  function()
-- 	local dashboard = require("alpha.themes.dashboard")
-- 	dashboard.section.buttons.val = {
-- 	}
-- 	require("alpha").setup(dashboard.opts)
-- end
