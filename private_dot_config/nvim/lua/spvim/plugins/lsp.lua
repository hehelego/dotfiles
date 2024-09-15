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
			source = true,
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
	-- if client.server_capabilities.codeLensProvider then
	-- 	local lsp_codelens_grp = vim.api.nvim_create_augroup("lsp_codelens", {})
	-- 	vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
	-- 		group = lsp_codelens_grp,
	-- 		desc = "refresh lsp codelens",
	-- 		callback = function() vim.lsp.codelens.refresh() end,
	-- 	})
	-- end

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

	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	lspconfig[server_name].setup(opts)
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		dependencies = {
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
			})
			clangd_setup("clangd")
			general_setup("rust_analyzer")
			general_setup("hls")
			general_setup("ocamllsp")
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
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				fish = { "fish_indent" },
				latex = { "latexindent" },
				ocaml = { "ocamlformat" },
				haskell = { "fourmolu" },
			},
			notify_on_error = true,
			default_format_opts = {
				timeout_ms = 3000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile", "BufAdd" },
		config = function()
			require("lint").linters_by_ft = {
				c = { "clangtidy" },
				cpp = { "clangtidy" },
				rust = { "clippy" },
				python = { "ruff" },
				fish = { "fish" },
				lua = { "selene" },
				latex = { "chktex" },
			}
			local grp = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					require("lint").try_lint()
				end,
				desc = "run linters on buffer write",
				group = grp,
			})
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		event = { "CursorHold", "CursorHoldI" },
		opts = { autocmd = { enabled = true } },
	},
	------------- extra filetypes ------------------
	{ -- for the coq proof assistant
		"whonore/Coqtail",
		ft = { "coq" },
	},
	{ -- for the agda proof assistant
		"isovector/cornelis",
		dependencies = {
			"kana/vim-textobj-user",
			"neovimhaskell/nvim-hs.vim",
		},
		build = "stack build",
		ft = { "agda" },
	},
	{ -- for TLA+ specifications
		"tlaplus-community/tlaplus-nvim-plugin",
		dependencies = "florentc/vim-tla",
		ft = { "tla" },
	},
}
