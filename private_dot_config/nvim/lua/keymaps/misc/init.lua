local wk = require("which-key")

wk.register({
	["z"] = { "<cmd>Telescope zoxide list<cr>", "zoxide" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>",
})

wk.register({
	["l"] = { "vimtex" },
}, {
	mode = "n",
	prefix = "<localleader>",
})
