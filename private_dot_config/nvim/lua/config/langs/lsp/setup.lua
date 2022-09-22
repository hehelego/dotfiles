local function L(mod)
	return require("config.langs.lsp." .. mod)
end

local diagnostic_signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(diagnostic_signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local diagnostic_config = {
	virtual_text = false,
	signs = { active = diagnostic_signs },
	update_in_insert = false, -- do not update diagnostic in insert mode
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}
vim.diagnostic.config(diagnostic_config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

local function on_attach(client, bufnr)
	_ = bufnr -- discard the argument
	local cap = client.resolved_capabilities

	-- add CursorHold highlighting
	if cap.document_highlight then
		local lsp_dochl_grp = vim.api.nvim_create_augroup("lsp_document_highlight", {})
		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			callback = vim.lsp.buf.document_highlight,
			group = lsp_dochl_grp,
			desc = "On CursorHold, highlight the reference of the symbol under cursor",
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			callback = vim.lsp.buf.clear_references,
			group = lsp_dochl_grp,
			desc = "On CursorMoved, clear lsp document_highlight",
			buffer = bufnr,
		})
	end

	-- replace the default omnifunc completion <c-x><c-o>
	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- add lsp_signature support
	local lspsignature = require("lsp_signature")
	lspsignature.on_attach({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
end

local server_config = L("lspserver_config")

local mason_lsp = require("mason-lspconfig")
mason_lsp.setup_handlers({
	function(server_name)
		local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}
		opts = vim.tbl_extend("force", opts, server_config[server_name] or {})

		local lspconfig = require("lspconfig")
		lspconfig[server_name].setup(opts)
	end,
})
