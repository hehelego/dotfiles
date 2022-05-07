require("which-key").register({
	name = "lsp",
	["t"] = {
		name = "troubles",
		["t"] = { "<cmd>TroubleToggle<cr>", "toggle" },
		["r"] = { "<cmd>TroubleRefresh<cr>", "refresh" },
		["c"] = { "<cmd>Trouble quickfix<cr>", "quickfix" },
		["l"] = { "<cmd>Trouble loclist<cr>", "loclist" },
		["d"] = { "<cmd>Trouble document_diagnostics<cr>", "diagnostics-file" },
		["D"] = { "<cmd>Trouble workspace_diagnostics<cr>", "diagnostics-ws" },
		["g"] = { "<cmd>Gitsigns setqflist<cr>", "git-diff-hunks" },
	},
	["g"] = {
		name = "goto",
		["r"] = { "<cmd>Telescope lsp_references<cr>", "references" },
		["d"] = { "<cmd>Telescope lsp_definitions<cr>", "definitions" },
		["i"] = { "<cmd>Telescope lsp_implementations<cr>", "implementations" },
		["t"] = { "<cmd>Telescope lsp_type_definitions<cr>", "typedef" },
		["s"] = { "<cmd>Telescope lsp_document_symbols<cr>", "symbols-file" },
		["S"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", "symbols-ws" },
	},
	["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code-action" },
	["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
	["f"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
}, { mode = "n", silent = true, noremap = true, prefix = ";" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
	silent = true,
	noremap = true,
	desc = "goto next diagnostic",
})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
	silent = true,
	noremap = true,
	desc = "goto next diagnostic",
})

-- show document
vim.keymap.set(
	"n",
	"K",
	vim.lsp.buf.hover,
	{ silent = true, noremap = true, desc = "show document for the symbol under cursor" }
)
vim.keymap.set(
	"n",
	"M",
	"<cmd>Man<cr>",
	{ silent = true, noremap = true, desc = "show man page for the symbol under cursor" }
)

vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {
	desc = "lsp document formatting",
})
