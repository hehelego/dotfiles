require("which-key").register({
	p = { "<cmd>BufferLinePick<cr>", "pick-goto" },
	c = { "<cmd>BufferLinePickClose<cr>", "pick-close" },
}, { mode = "n", silent = true, noremap=true, prefix = "<leader>b" })

-- goto the k-th buffer on the bufferline
for i = 1, 9, 1 do
	vim.keymap.set(
		"n",
		string.format("<M-%d>", i),
		string.format("<cmd>BufferLineGoToBuffer %d<cr>", i),
		{ silent = true, noremap = true, desc = string.format("goto buffer %d", i) }
	)
end
