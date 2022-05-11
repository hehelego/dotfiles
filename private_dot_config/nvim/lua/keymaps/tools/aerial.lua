require("which-key").register({
	name = "aerial",
	["a"] = { "<cmd>AerialToggle<cr>", "toggle" },
	["o"] = { "<cmd>AerialOpen<cr>", "open" },
	["c"] = { "<cmd>AerialClose<cr>", "close" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>a",
})
