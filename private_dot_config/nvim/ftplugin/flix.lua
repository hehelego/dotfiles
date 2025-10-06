require("flix").setup()
vim.lsp.enable("flix")

-- import the `flix_cmd` function
local flix_cmd = require("flix.commands").flix_cmd
-- setting `bufnr` prevents keybindings from being set to other filetypes
local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<Space>br", function()
	flix_cmd("run")
end, { noremap = true, silent = true, buffer = bufnr, desc = "run flix project" })
vim.keymap.set("n", "<Space>bt", function()
	flix_cmd("test")
end, { noremap = true, silent = true, buffer = bufnr, desc = "run flix project" })
