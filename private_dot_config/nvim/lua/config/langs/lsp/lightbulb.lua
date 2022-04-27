-- See <https://github.com/kosayoda/nvim-lightbulb>

-- add lightbulb code action sign
local lightbulb = require("nvim-lightbulb")
local lbgrp = vim.api.nvim_create_augroup("lsp_lightbulb", {})
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = lightbulb.update_lightbulb,
	group = lbgrp,
	desc = "show a lightbulb on sign-column when code-action is available",
})
