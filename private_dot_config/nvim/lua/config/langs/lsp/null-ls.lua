-- See <https://github.com/jose-elias-alvarez/null-ls.nvim>
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	sources = {
		formatting.yapf,
		formatting.stylua,
		formatting.rustfmt,
		formatting.clang_format,
		diagnostics.flake8,
		diagnostics.chktex,
		code_actions.gitsigns,
	},
})
