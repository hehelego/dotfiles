-- See <https://github.com/nvim-treesitter/nvim-treesitter>
-- See <https://github.com/p00f/nvim-ts-rainbow>
-- See <https://github.com/nvim-treesitter/playground>

-- NOTE: by default, treesitter modules are disabled

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- general purpose programming
		"c",
		"cpp",
		"python",
		"rust",
		"go",
		"haskell",
		"scheme",
		-- HPC
		"cuda",
		"fortran",
		-- shell scripts
		"fish",
		"bash",
		-- config files
		"yaml",
		"toml",
		-- vim/neovim
		"vim",
		"lua",
		"help",
		"query",
		-- doc files
		"markdown",
		"rst",
		"latex",
	},

	sync_install = false,

	-- use git to install parsers
	prefer_git = true,

	-- syntax highlighting module
	highlight = {
		enable = false,
		-- list, ddisable treesitter for the listed languages
		-- (these are the **names of the parsers** and not the **filetype**)
		disable = {},
		additional_vim_regex_highlighting = false,
	},

	-- indentation module
	indent = { enable = false },

	-- see https://github.com/p00f/nvim-ts-rainbow
	rainbow = {
		enable = false,
		disable = {}, -- list of languages you want to disable the plugin for
		-- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		extended_mode = true,
		-- Do not enable for files with more than n lines, int
		max_file_lines = 10000,
	},
})
