return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"andymass/vim-matchup",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {},
				highlight = {
					enable = true,
					disable = function(ft, bufnr)
						local _ = ft
						return not vim.g.bigfile(bufnr)
					end,
					additional_vim_regex_highlighting = true,
				},
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]["] = "@function.outer",
							["]m"] = "@class.outer",
						},
						goto_next_end = {
							["]]"] = "@function.outer",
							["]M"] = "@class.outer",
						},
						goto_previous_start = {
							["[["] = "@function.outer",
							["[m"] = "@class.outer",
						},
						goto_previous_end = {
							["[]"] = "@function.outer",
							["[M"] = "@class.outer",
						},
					},
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				matchup = {
					enable = true,
				},
			})
		end,
	},
}
