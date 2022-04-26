local function ui_plugins(use)
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

	-- make color-name and hex-color colorful
	use("norcalli/nvim-colorizer.lua")
end
return ui_plugins
