local function ui_plugins(use)
	-- prettify the vim.ui functions
	use("stevearc/dressing.nvim")

	-- nerd font dev-icons
	use("kyazdani42/nvim-web-devicons")

	-- colorscheme nightfox.nvim
	use("EdenEast/nightfox.nvim")

	-- startup dashboard
	use("goolord/alpha-nvim")

	-- status line
	use("nvim-lualine/lualine.nvim")
	-- tab/buffer line
	use("akinsho/bufferline.nvim")
end
return ui_plugins
