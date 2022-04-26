local function cmp_plugins(use)
	-- the nvim-cmp completion plugin
	use("hrsh7th/nvim-cmp")

	-- the completion source
	use("hrsh7th/cmp-nvim-lsp") -- lsp completion source
	use("hrsh7th/cmp-nvim-lua") -- neovim lua api
	use("saadparwaiz1/cmp_luasnip") -- LuaSnip code snippet
	use("hrsh7th/cmp-buffer") -- words from buffer
	use("hrsh7th/cmp-path") -- file system path
	use("hrsh7th/cmp-cmdline") -- vim command-line mode completion
end

local function snippet_plugins(use)
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
end

local function treesitter_plugins(use)
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	use("p00f/nvim-ts-rainbow") -- colorize parenthesis/brackets/braces
	use("nvim-treesitter/playground") -- show tree-sitter parsing result
end

local function lsp_plugins(use)
	-- configure the neovim builtin lsp client
	use("neovim/nvim-lspconfig")
	-- manage lsp servers with nvim-lsp-installer
	use("williamboman/nvim-lsp-installer")

	-- use clang-tidy/flake8/cargo-clippy as LSP servers
	use("jose-elias-alvarez/null-ls.nvim")

	-- show function signature for completion
	use("ray-x/lsp_signature.nvim")
end

local function langs_plugins(use)
	cmp_plugins(use)

	snippet_plugins(use)

	treesitter_plugins(use)

	lsp_plugins(use)
end

return langs_plugins
