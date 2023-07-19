return {
	{ "folke/lazy.nvim", tag = "stable" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
	{ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } },
	{ "nvim-lua/plenary.nvim", lazy = true },
}
