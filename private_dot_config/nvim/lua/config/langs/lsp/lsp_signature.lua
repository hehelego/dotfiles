-- See <https://github.com/ray-x/lsp_signature.nvim>

local lspsignature = require("lsp_signature")
lspsignature.setup({
	bind = true,
	handler_opts = {
		border = "rounded",
	},
})
