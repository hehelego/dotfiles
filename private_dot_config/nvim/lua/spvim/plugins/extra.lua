return {
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
		config = function()
			vim.g.mkdp_refresh_slow = 1
			vim.g.mkdp_browser = "qutebrowser"
		end,
	},
	{
		"preservim/vim-markdown",
		dependencies = "godlygeek/tabular",
		ft = "markdown",
		config = function()
			-- more LaTeX math conceal
			vim.g.tex_flavor = "latex"
			vim.g.tex_conceal = "abdgms"
			-- enable conceal
			vim.g.vim_markdown_conceal = 1
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_conceal_code_blocks = 1
			-- enable frontmatter headers
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_toml_frontmatter = 1
			vim.g.vim_markdown_json_frontmatter = 1
		end,
	},
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			-- allow overwriting the default tex filetype syntax&highlight
			vim.g.tex_flavor = "latex"
			-- allow vimtex symbol concealing
			vim.g.tex_conceal = "abdgms"

			-- do not open quickfix window automatically
			vim.g.vimtex_quickfix_mode = 0
			-- use zathura as PDF viewer
			vim.g.vimtex_view_method = "zathura"
			-- use tectonic as default TeX engine
			vim.g.vimtex_compiler_method = "latexmk"
			-- enable vimtex folding feature
			vim.g.vimtex_fold_enabled = 1
			-- enable vimtex indentation feature
			vim.g.vimtex_indent_enabled = 1
			-- disable vimtex code formatting, use null-ls
			vim.g.vimtex_format_enabled = 0

			-- For SyncTeX support in Zathura, edit `~/.config/zathura/zathurarc` and add
			-- set synctex true
			-- set synctex-editor-command "nvim --headless -c \"VimtexInverseSearch %l '%f'\""

			-- highlight for concealed LaTeX symbols
			vim.cmd.highlight({ "clear", "Conceal" })
			vim.cmd.highlight({ "link", "Conceal", "Type" })
		end,
	},
	{
		"zk-org/zk-nvim",
		event = "VeryLazy",
		main = "zk",
		opts = {
			picker = "telescope",

			lsp = {
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
				},

				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
			},
		},
	},
	{
		"flix/nvim",
		event = "VeryLazy",
		name = "flix.nvim",
	},
}
