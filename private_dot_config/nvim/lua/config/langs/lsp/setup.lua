local function L(mod)
	return require("config.langs.lsp." .. mod)
end
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local lspsignature = require("lsp_signature")
local server_config = L("config")
local other_servers = { "pyright", "rust_analyzer", "gopls", "clangd", "texlab" }

-- NOTE: <https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428>
capabilities.offsetEncoding = { "utf-16" }

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
		vim.cmd([[
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]])
	end

	-- replace the default omnifunc completion <c-x><c-o>
	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- add lsp_signature support
	lspsignature.on_attach({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
end

-- load servers installed by nvim-lsp-installer
installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	opts = vim.tbl_extend("force", opts, server_config(server.name))
	-- this `setup(opt)` is same to `lspconfig[server].setup(opt)`
	server:setup(opts)
end)
-- load previously existed servers on the system
for _, server in ipairs(other_servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	opts = vim.tbl_extend("force", opts, server_config(server))
	lspconfig[server].setup(opts)
end
