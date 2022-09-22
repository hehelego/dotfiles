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
		-- C/C++
		"clangd",
		-- rust
		"rust_analyzer",
		-- python
		"pyright",
		-- lua
		"sumneko_lua",
		-- vim script
		"vimls",
		-- LaTeX
		"texlab",
	},
})
