-- See <https://github.com/jose-elias-alvarez/null-ls.nvim>
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local src = {}
-- formatter
src = vim.list_extend(src, {
	formatting.yapf,
	formatting.stylua,
	formatting.rustfmt,
})
-- diagnostics
src = vim.list_extend(src, {
	diagnostics.pylint,
	diagnostics.chktex,
	diagnostics.fish,
})
-- code action
src = vim.list_extend(src, {
	code_actions.gitsigns,
})

null_ls.setup({
	sources = src,
})
