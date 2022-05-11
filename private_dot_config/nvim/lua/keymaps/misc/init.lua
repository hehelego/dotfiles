require("which-key").register({
	["z"] = { "<cmd>Telescope zoxide list<cr>", "zoxide" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>",
})
