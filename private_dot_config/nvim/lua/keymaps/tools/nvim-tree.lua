local bind = vim.keymap.set
bind("n", "<leader>e", ":NvimTreeToggle<cr>")

local wk = require("which-key")

wk.register({
	e = "file-explorer",
}, { mode = "n", prefix = "<leader>" })
