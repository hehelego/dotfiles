local bind = function(func, opts)
	return function()
		func(opts)
	end
end

require("which-key").register({
	name = "lsp",
	["g"] = {
		name = "goto",
		["r"] = { "<cmd>Telescope lsp_references<cr>", "references" },
		["d"] = { "<cmd>Telescope lsp_definitions<cr>", "definitions" },
		["i"] = { "<cmd>Telescope lsp_implementations<cr>", "implementations" },
		["t"] = { "<cmd>Telescope lsp_type_definitions<cr>", "typedef" },
		["s"] = { "<cmd>Telescope lsp_document_symbols<cr>", "symbols-file" },
		["S"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", "symbols-ws" },
	},
	["a"] = { vim.lsp.buf.code_action, "code-action" },
	["A"] = { vim.lsp.codelens.run, "codelens-action" },
	["r"] = { vim.lsp.buf.rename, "rename" },
	["f"] = { bind(vim.lsp.buf.format, { async = true }), "format" },
	["h"] = { vim.lsp.buf.signature_help(), "signature-help" },
}, {
	mode = "n",
	silent = true,
	prefix = ";",
})
vim.keymap.set({ "v", "x" }, ";f", bind(vim.lsp.buf.format, { async = true }), {
	silent = true,
	desc = "run formatter for the current buffer",
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
	silent = true,
	desc = "goto next diagnostic",
})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
	silent = true,
	desc = "goto next diagnostic",
})

-- show document
vim.keymap.set("n", "K", vim.lsp.buf.hover, {
	silent = true,
	desc = "show document for the symbol under cursor",
})
vim.keymap.set("n", "M", "<cmd>Man<cr>", {
	silent = true,
	desc = "show man page for the symbol under cursor",
})

vim.api.nvim_create_user_command("Format", bind(vim.lsp.buf.format, { async = true }), {
	desc = "lsp document formatting",
})
