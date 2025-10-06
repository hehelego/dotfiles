local function telescope_setup()
	local telescope = require("telescope")
	local default_theme = require("telescope.themes").get_ivy()
	telescope.setup({
		defaults = default_theme,
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
end

local function nvim_tree_setup()
	local nvim_tree = require("nvim-tree")
	local on_attach = require("spvim.maps_cmds.nvim-tree-on-attach")

	-- See: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#make-q-and-bd-work-as-if-tree-was-not-visible
	-- Make :bd and :q behave as usual when tree is visible
	vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
		nested = false,
		callback = function(e)
			local tree = require("nvim-tree.api").tree

			-- Nothing to do if tree is not opened
			if not tree.is_visible() then
				return
			end

			-- How many focusable windows do we have? (excluding e.g. incline status window)
			local winCount = 0
			for _, winId in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_config(winId).focusable then
					winCount = winCount + 1
				end
			end

			-- We want to quit and only one window besides tree is left
			if e.event == "QuitPre" and winCount == 2 then
				vim.api.nvim_cmd({ cmd = "qall" }, {})
			end

			-- :bd was probably issued an only tree window is left
			-- Behave as if tree was closed (see `:h :bd`)
			if e.event == "BufEnter" and winCount == 1 then
				-- Required to avoid "Vim:E444: Cannot close last window"
				vim.defer_fn(function()
					-- close nvim-tree: will go to the last buffer used before closing
					tree.toggle({ find_file = true, focus = true })
					-- re-open nivm-tree
					tree.toggle({ find_file = true, focus = false })
				end, 10)
			end
		end,
	})

	local opts = {
		sync_root_with_cwd = true,
		on_attach = on_attach,
		renderer = {
			indent_markers = {
				enable = true,
			},
			hidden_display = "all",
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
			debounce_delay = 200,
			show_on_dirs = true,
			show_on_open_dirs = false,
		},
		modified = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = false,
		},
		trash = {
			cmd = "trash",
		},
	}
	nvim_tree.setup(opts)
end

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
		config = telescope_setup,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
		config = nvim_tree_setup,
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
		cmd = { "Trouble", "TodoTrouble", "TodoLocList", "TodoQuickFix", "TodoTelescope" },
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
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewFocusFiles",
			"DiffviewToggleFiles",
		},
		config = true,
	},
}
