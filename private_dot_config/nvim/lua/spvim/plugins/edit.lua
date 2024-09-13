return {
	-- plugin for comments
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		config = true,
	},

	-- color matched pairs {[()]}
	{
		"hiphish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
	},

	-- double character easymotion: <localleader>s {char1}{char2}
	{
		"ggandor/leap.nvim",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
	},

	-- single character easymotion
	{
		"ggandor/flit.nvim",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		opts = {
			keys = { f = "f", F = "F", t = "t", T = "T" },
			labeled_modes = "nvo",
			multiline = true,
			opts = {},
		},
	},
}
