return {
	{ "folke/lazy.nvim", tag = "stable" },
	{
		"folke/which-key.nvim",
		dependencies = {
			"echasnovski/mini.icons",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		opts = { preset = "helix", icons = { mappings = false } },
	},
	{ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } },
	{ "nvim-lua/plenary.nvim", lazy = true },
}
