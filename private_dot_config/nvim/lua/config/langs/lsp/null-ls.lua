-- See <https://github.com/jose-elias-alvarez/null-ls.nvim>
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local src = {}
-- formatter
src = vim.tbl_extend("force", src, {
	formatting.yapf,
	formatting.stylua,
	formatting.rustfmt,
	formatting.clang_format,
})
-- diagnostics
src = vim.tbl_extend("force", src, {
	diagnostics.pylint,
	diagnostics.chktex,
	diagnostics.fish,
})
-- code action
src = vim.tbl_extend("force", src, {
	code_actions.gitsigns,
})

null_ls.setup({
	sources = src,
})
