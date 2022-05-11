vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {
	desc = "toggle nvim-tree file explorer",
})

local wk = require("which-key")

wk.register({
	e = "file-explorer",
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>",
})
