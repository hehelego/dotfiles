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

local lspinstaller = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local server_config = L("config")
local other_servers = { "pyright", "rust_analyzer", "gopls", "clangd", "texlab" }

-- update the neovim LSP client capability
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.offsetEncoding = { "utf-16" } -- NOTE: <https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428>

lspinstaller.setup({})

local function config_one(server_name)
	local s = server_name
	print('setup ' .. s)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	opts = vim.tbl_extend("force", opts, server_config(s))
	lspconfig[s].setup(opts)
end

-- load servers installed by nvim-lsp-installer
for _, server_obj in ipairs(lspinstaller.get_installed_servers()) do
	config_one(server_obj.name)
end
-- load previously existed servers on the system
for _, server in ipairs(other_servers) do
	config_one(server)
end
