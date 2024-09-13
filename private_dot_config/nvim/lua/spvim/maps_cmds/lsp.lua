local wk = require("which-key")

local function buf_fmt_async()
	require("conform").format()
end

wk.add({
	{ ";", group = "lsp" },
	{ ";A", vim.lsp.codelens.run, desc = "codelens-action" },
	{ ";a", vim.lsp.buf.code_action, desc = "code-action" },
	{ ";f", buf_fmt_async, desc = "formatter", mode = { "n", "x" } },
	{ ";r", vim.lsp.buf.rename, desc = "rename" },
	{ ";h", vim.lsp.buf.signature_help, desc = "signature-help" },
})
wk.add({
	{ ";g", group = "lsp navigation" },
	{ ";gS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "symbols-ws" },
	{ ";gd", "<cmd>Telescope lsp_definitions<cr>", desc = "definitions" },
	{ ";gi", "<cmd>Telescope lsp_implementations<cr>", desc = "implementations" },
	{ ";gr", "<cmd>Telescope lsp_references<cr>", desc = "references" },
	{ ";gs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "symbols-file" },
	{ ";gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "typedef" },
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
	desc = "show document for the symbol under cursor",
})
vim.keymap.set("n", "M", "<cmd>Man<cr>", {
	desc = "show man page for the symbol under cursor",
})

vim.api.nvim_create_user_command("Format", buf_fmt_async, {
	desc = "lsp document formatting",
})
