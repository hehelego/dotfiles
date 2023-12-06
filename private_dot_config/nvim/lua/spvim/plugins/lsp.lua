local function lspclient_setup()
	local diagnostic_signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(diagnostic_signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	vim.diagnostic.config({
		virtual_text = false,
		signs = { active = diagnostic_signs },
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "single",
	})
end

local function on_attach(client, bufnr)
	_ = bufnr -- discard the argument

	-- add CursorHold document highlighting
	if client.server_capabilities.documentHighlightProvider then
		local lsp_dochl_grp = vim.api.nvim_create_augroup("lsp_document_highlight", {})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
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

	-- add BufEnter, InsertLeave, CursorHold codelens
	if client.server_capabilities.codeLensProvider then
		local lsp_codelens_grp = vim.api.nvim_create_augroup("lsp_codelens", {})
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			group = lsp_codelens_grp,
			desc = "refresh lsp codelens",
			callback = vim.lsp.codelens.refresh,
			buffer = bufnr,
		})
	end

	require("lsp_signature").on_attach({
		bind = true,
		fix_pos = true,
		handler_opts = {
			border = "single",
		},
	}, bufnr)
end

local function general_setup(server_name)
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	lspconfig[server_name].setup(opts)
end

-- special configuration for lua-ls
local function luals_setup(server_name)
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	opts = vim.tbl_deep_extend("force", opts, {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = { vim.env.VIMRUNTIME },
					checkThirdParty = false,
				},
				telemetry = { enable = false },
				format = { enable = false },
			},
		},
	})

	lspconfig[server_name].setup(opts)
end
-- special configuration for clangd
local function clangd_setup(server_name)
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- NOTE: issue on offset encoding
	-- see <https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428>
	-- see <https://github.com/neovim/neovim/pull/16694>
	capabilities.offsetEncoding = { "utf-16" }

	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	lspconfig[server_name].setup(opts)
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"ray-x/lsp_signature.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")

			lspclient_setup()

			mason.setup({})
			mason_lsp.setup({})

			mason_lsp.setup_handlers({
				general_setup,
				["lua_ls"] = luals_setup,
				["clangd"] = clangd_setup,
			})
			clangd_setup('clangd')
			general_setup('hls')
			general_setup('ocamllsp')
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		lazy = true,
		config = function()
			local null_ls = require("null-ls")
			local b = null_ls.builtins

			null_ls.setup({
				sources = {
					-- formatting
					b.formatting.prettier,
					b.formatting.prettierd,
					b.formatting.latexindent,
					b.formatting.stylua,
					b.formatting.rustfmt,
					b.formatting.clang_format,
					b.formatting.fish_indent,
					b.formatting.yapf,
					b.formatting.fourmolu,
					b.formatting.ocamlformat,
					b.formatting.sql_formatter,
					-- diagnostic
					b.diagnostics.fish,
					b.diagnostics.revive,
					-- code action
					b.code_actions.gitsigns,
					b.code_actions.gitrebase,
					-- hover
				},
				options = {
					debounce = vim.opt.timeoutlen:get(),
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = "neovim/nvim-lspconfig",
		cmd = {
			"Mason",
			"MasonUpdate",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		event = { "CursorHold", "CursorHoldI" },
		opts = { autocmd = { enabled = true } },
	},
}
