-- See <https://github.com/williamboman/mason.nvim>
-- See <https://github.com/williamboman/mason-lspconfig.nvim>

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
		},
	},
})

mason_lsp.setup({
	ensure_installed = {
		-- C/C++
		"clangd",
		-- rust
		"rust_analyzer",
		-- python
		"pyright",
		-- lua
		"sumneko_lua",
		-- vim script
		"vimls",
		-- LaTeX
		"texlab",
	},
})

-- setup lsp server and client with mason-lspconfig

-- the default LSP client buffer attach callback
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
end

local server_conf = {
	["clangd"] = {
		args = {
			"--background-index",
			"--pch-storage=memory",
			"-std=c++17",
			"--clang-tidy",
			"--offset-encoding=utf-16",
		},
	},
	["rust_analyzer"] = {},
	["pyright"] = {},
	["sumneko_lua"] = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	["vimls"] = {},
	["texlab"] = {},
}

mason_lsp.setup_handlers({
	function(server_name)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

		-- NOTE: issue on offset encoding
		-- see <https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428>
		-- see <https://github.com/neovim/neovim/pull/16694>
		capabilities.offsetEncoding = { "utf-16" }
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}
		opts = vim.tbl_deep_extend("force", opts, server_conf[server_name] or {})
		lspconfig[server_name].setup(opts)
	end,
})
