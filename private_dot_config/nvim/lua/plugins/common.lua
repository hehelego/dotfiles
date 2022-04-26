local function common_plugins(use)
	-- use packer.nvim to manage itself
	use("wbthomason/packer.nvim")

	-- implementation of neovim popup API
	use("nvim-lua/popup.nvim")
	-- provide helpful lua functions
	use("nvim-lua/plenary.nvim")
end
return common_plugins
