local function editing_plugins(use)
	-- plugin for comments
	use("numToStr/Comment.nvim")

	-- visualize indentation
	use("lukas-reineke/indent-blankline.nvim")

	-- hop.nvim lua-version of easymotion
	use("phaazon/hop.nvim")
end
return editing_plugins
