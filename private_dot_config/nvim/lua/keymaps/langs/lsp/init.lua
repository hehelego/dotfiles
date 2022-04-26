local reg = require("which-key").register

reg({
	name = "lsp",
	["t"] = {
		name = "troubles",
		["t"] = { "<cmd>TroubleToggle<cr>", "toggle" },
		["r"] = { "<cmd>TroubleRefresh<cr>", "refresh" },
		["c"] = { "<cmd>Trouble quickfix<cr>", "quickfix" },
		["l"] = { "<cmd>Trouble loclist<cr>", "loclist" },
		["d"] = { "<cmd>Trouble document_diagnostics<cr>", "diagnostics-file" },
		["D"] = { "<cmd>Trouble workspace_diagnostics<cr>", "diagnostics-ws" },
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
	["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
	["f"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
}, { mode = "n", prefix = ";", silent = true, noremap = true })

-- show document
vim.keymap.set("n", "K", function()
	if vim.lsp.buf.server_ready() then
		vim.lsp.buf.hover()
	else
		vim.cmd("Man")
	end
end, { noremap = true, silent = true })

vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
