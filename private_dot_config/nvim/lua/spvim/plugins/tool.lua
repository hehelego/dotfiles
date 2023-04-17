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
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
		config = function()
			local nvim_tree = require("nvim-tree")
			local on_attach = require("spvim.maps_cmds.nvim-tree")

			local opts = {
				auto_reload_on_write = true,
				disable_netrw = false,
				sort_by = "name",
				root_dirs = {},
				sync_root_with_cwd = true,
				on_attach = on_attach,
				view = {
					centralize_selection = false,
					cursorline = true,
					debounce_delay = 50,
					width = 30,
					hide_root_folder = false,
					side = "left",
					number = true,
					relativenumber = true,
					signcolumn = "yes",
				},
				renderer = {
					add_trailing = false,
					group_empty = false,
					highlight_git = false,
					full_name = false,
					highlight_opened_files = "none",
					highlight_modified = "none",
					root_folder_label = ":~:s?$?/..?",
					indent_width = 2,
					indent_markers = {
						enable = true,
						inline_arrows = true,
					},
					icons = {
						webdev_colors = true,
						git_placement = "before",
						modified_placement = "after",
						padding = " ",
						symlink_arrow = " ➛ ",
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
							modified = true,
						},
					},
					special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
					symlink_destination = true,
				},
				hijack_directories = {
					enable = true,
					auto_open = true,
				},
				update_focused_file = {
					enable = false,
					update_root = false,
					ignore_list = {},
				},
				system_open = {
					cmd = "xdg-open",
					args = {},
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					debounce_delay = 50,
					severity = {
						min = vim.diagnostic.severity.HINT,
						max = vim.diagnostic.severity.ERROR,
					},
				},
				filters = {
					dotfiles = false,
					git_clean = false,
					no_buffer = false,
					custom = {},
					exclude = {},
				},
				filesystem_watchers = {
					enable = true,
					debounce_delay = 50,
					ignore_dirs = {},
				},
				git = {
					enable = true,
					ignore = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					timeout = 500,
				},
				modified = {
					enable = false,
					show_on_dirs = true,
					show_on_open_dirs = true,
				},
				actions = {
					use_system_clipboard = true,
					change_dir = {
						enable = true,
						global = false,
						restrict_above_cwd = false,
					},
					expand_all = {
						max_folder_discovery = 300,
						exclude = {},
					},
					file_popup = {
						open_win_config = {
							col = 1,
							row = 1,
							relative = "cursor",
							border = "shadow",
							style = "minimal",
						},
					},
					open_file = {
						quit_on_open = false,
						resize_window = true,
						window_picker = {
							enable = true,
							picker = "default",
							chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
							exclude = {
								filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
								buftype = { "nofile", "terminal", "help" },
							},
						},
					},
					remove_file = {
						close_window = true,
					},
				},
				trash = {
					cmd = "trash",
				},
				live_filter = {
					prefix = "[FILTER]: ",
					always_show_folders = true,
				},
				tab = {
					sync = {
						open = false,
						close = false,
						ignore = {},
					},
				},
				ui = {
					confirm = {
						remove = true,
						trash = true,
					},
				},
				log = {
					enable = false,
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
		config = function()
			require("aerial").setup({
				backends = { "markdown", "man", "lsp", "treesitter" },
				layout = {
					-- open aerial at the far right/left of the editor
					placement = "edge",
				},
				--   aerial window will display symbols for the buffer in the window from which it was opened
				attach_mode = "window",
				-- Disable aerial on large file
				disable_max_lines = 10000, -- 10K Lines
				-- Disable aerial on large file
				disable_max_size = 2000000, -- 2 MegaBytes
				-- display all symbols
				filter_kind = false,
				-- Highlight the closest symbol if the cursor is not exactly on one.
				highlight_closest = true,
				-- Highlight the symbol in the source buffer when cursor is in the aerial win
				highlight_on_hover = true,
				-- Highlight the source code section after jumping for 300 ms
				highlight_on_jump = 300,
				ignore = {
					-- Ignore unlisted buffers. See :help buflisted
					unlisted_buffers = true,
					-- List of filetypes to ignore.
					filetypes = {},
				},
				-- Use symbol tree for folding. Set to true or false to enable/disable
				-- Set to "auto" to manage folds if your previous foldmethod was 'manual'
				-- This can be a filetype map (see :help aerial-filetype-map)
				manage_folds = false,
				-- When you fold code with za, zo, or zc, update the aerial tree as well.
				-- Only works when manage_folds = true
				link_folds_to_tree = false,
				-- Fold code when you open/collapse symbols in the tree.
				-- Only works when manage_folds = true
				link_tree_to_folds = true,
				-- Do not close aerial after jump to selected symbol
				close_on_select = false,
				-- The autocmds that trigger symbols update (not used for LSP backend)
				update_events = "TextChanged,InsertLeave",
				-- Show box drawing characters for the tree hierarchy
				show_guides = true,
				-- Customize the characters used when show_guides = true
				guides = {
					-- When the child item has a sibling below it
					mid_item = "├─",
					-- When the child item is the last in the list
					last_item = "└─",
					-- When there are nested child guides to the right
					nested_top = "│ ",
					-- Raw indentation
					whitespace = "  ",
				},
				lsp = {
					-- Fetch document symbols when LSP diagnostics update.
					-- If false, will update on buffer changes.
					diagnostics_trigger_update = true,
					-- Set to false to not update the symbols when there are LSP errors
					update_when_errors = true,
					-- How long to wait (in ms) after a buffer change before updating
					-- Only used when diagnostics_trigger_update = false
					update_delay = vim.opt.timeoutlen:get(),
				},
				treesitter = {
					-- How long to wait (in ms) after a buffer change before updating
					update_delay = 300,
				},
				markdown = {
					-- How long to wait (in ms) after a buffer change before updating
					update_delay = 300,
				},
				man = {
					-- How long to wait (in ms) after a buffer change before updating
					update_delay = 300,
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "folke/trouble.nvim",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		config = function()
			require("todo-comments").setup({})

			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
		end,
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
		"TimUntersberger/neogit",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = "Neogit",
	},
}
