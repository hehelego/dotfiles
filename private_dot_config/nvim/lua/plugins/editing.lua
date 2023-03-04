local function editing_plugins(use)
	-- plugin for comments
	use("numToStr/Comment.nvim")

	-- visualize indentation
	use("lukas-reineke/indent-blankline.nvim")

	-- double character easymotion: <localleader>s {char1}{char2}
	use("ggandor/leap.nvim")

	-- single character easymotion
	use({ "ggandor/flit.nvim", requires = { "ggandor/leap.nvim" } })
end
return editing_plugins
