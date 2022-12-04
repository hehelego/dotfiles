-- See <https://github.com/wbthomason/packer.nvim>
-- I use packer.nvim to manage all the plugins and packer.nvim itself.

local function L(mod)
	return require("plugins." .. mod)
end

-- packer bootstrapping
local bootstrap = nil
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	print("[NOTE] Packer is not installed yet. Trying to fetch packer.nvim from github")
	bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		packer_path,
	})
	print("[NOTE] Packer.nvim have just been installed. Please restart neovim later ...")
	vim.cmd("packadd packer.nvim")
end
local packer = require("packer")

-- plugins
local _ = {
	common = {
		packer = "wbthomason/packer.nvim",
		popup = "nvim-lua/popup.nvim",
		plenary = "nvim-lua/plenary.nvim",
	},
	ui = {
		dressing = "stevearc/dressing.nvim",
		devicons = "kyazdani42/nvim-web-devicons",
		nightfox = "EdenEast/nightfox.nvim",
		alpha = "goolord/alpha-nvim",
		lualine = "nvim-lualine/lualine.nvim",
		tabline = "akinsho/bufferline.nvim",
	},
	tools = {
		which_key = "folke/which-key.nvim",
		telescope = "nvim-telescope/telescope.nvim",
		telescope_extensions = {
			fzf_native = "nvim-telescope/telescope-fzf-native.nvim",
			zoxide = "jvgrootveld/telescope-zoxide",
		},
		trouble = "folke/trouble.nvim",
		todo_comments = "folke/todo-comments.nvim",
		nvim_tree = "kyazdani42/nvim-tree.lua",
		aerial = "stevearc/aerial.nvim",
		gitsigns = "lewis6991/gitsigns.nvim",
	},
	editing = {
		comment = "numToStr/Comment.nvim",
		indent_line = "lukas-reineke/indent-blankline.nvim",
		hop = "phaazon/hop.nvim",
	},
	langs = {
		cmp = {
			base = "hrsh7th/nvim-cmp",
			source_lsp = "hrsh7th/cmp-nvim-lsp",
			source_nvim_lua = "hrsh7th/cmp-nvim-lua",
			source_snippet = "saadparwaiz1/cmp_luasnip",
			source_buffer = "hrsh7th/cmp-buffer",
			source_path = "hrsh7th/cmp-path",
			source_cmdline = "hrsh7th/cmp-cmdline",
		},
		snippet = {
			engine = "L3MON4D3/LuaSnip",
			source = "rafamadriz/friendly-snippets",
		},
		tree_sitter = {
			base = "nvim-treesitter/nvim-treesitter",
			rainbow = "p00f/nvim-ts-rainbow",
			playground = "nvim-treesitter/playground",
		},
		lsp = {
			base = "neovim/nvim-lspconfig",
			mason = "williamboman/mason.nvim",
			mason_lspconfig = "williamboman/mason-lspconfig.nvim",
			null_ls = "jose-elias-alvarez/null-ls.nvim",
			lsp_signature = "ray-x/lsp_signature.nvim",
			lightbulb = "kosayoda/nvim-lightbulb",
			lspkind = "onsails/lspkind.nvim",
		},
	},
	misc = {
		startuptime = "dstein64/vim-startuptime",
		impatient = "lewis6991/impatient.nvim",
		polyglot = "sheerun/vim-polyglot",
		markdown_preview = "iamcco/markdown-preview.nvim",
		vimtex = "lervag/vimtex",
	},
}

packer.startup(function(use)
	L("common")(use)
	L("ui")(use)
	L("tools")(use)
	L("editing")(use)
	L("langs")(use)
	L("misc")(use)

	-- on bootstrapping, call packer.sync
	if bootstrap then
		packer.sync()
	end
end)
