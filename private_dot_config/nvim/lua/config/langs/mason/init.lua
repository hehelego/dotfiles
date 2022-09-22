-- See https://github.com/williamboman/mason.nvim
-- See https://github.com/williamboman/mason-lspconfig.nvim

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
		},
	},
})

mason_lsp.setup({
	ensure_installed = {
		"clangd",
		"rust_analyzer",
		"lua-language-server",
	},
})
