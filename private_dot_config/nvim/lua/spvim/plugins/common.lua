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
	{ "nvim-lua/plenary.nvim", lazy = true },
}
