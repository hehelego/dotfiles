return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"mrjones2014/nvim-ts-rainbow",
			"andymass/vim-matchup",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {},
				highlight = {
					enable = true,
					disable = function(ft, bufnr)
						local _ = ft
						local max_size, max_lines = 0x400000, 0x4000 -- 4 MB, 16384 lines
						local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
						local lines = vim.api.nvim_buf_line_count(bufnr)
						if (ok and stat) and (stat.size < max_size and lines < max_lines) then
							return false
						else
							return true
						end
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
				rainbow = {
					enable = true,
					extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
					max_file_lines = 4096, -- Do not enable for files with more than 2000 lines, int
				},
				context_commentstring = { enable = true, enable_autocmd = false },
				matchup = { enable = true },
			})
		end,
	},
}
