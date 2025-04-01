local function lspclient_setup()
	vim.diagnostic.config({
		virtual_text = false,
		underline = true,
		update_in_insert = false,
		severity_sort = false,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			-- highlight the symbol under the cursor
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

			-- refresh codelens
			if client.server_capabilities.codeLensProvider then
				vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
					callback = function()
						vim.lsp.codelens.refresh({ bufnr = bufnr })
					end,
					group = vim.api.nvim_create_augroup("lsp_codelens", {}),
					desc = "refresh lsp codelens",
					buffer = bufnr,
				})
			end

			-- provide inlay hints
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
		desc = "Setup LSP client on LspAttach event",
		group = vim.api.nvim_create_augroup("LspClientSetupGroup", {}),
	})
end

local function general_setup(server_name)
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	local opts = { capabilities = capabilities }
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

			mason_lsp.setup_handlers({ general_setup })
			general_setup("clangd")
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
		"ray-x/lsp_signature.nvim",
		opts = {},
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
				tex = { "latexindent" },
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
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					require("lint").try_lint()
				end,
				desc = "run linters on buffer write",
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			})
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		event = { "CursorHold", "CursorHoldI" },
		opts = {
			priority = 20,
			autocmd = { enabled = true },
		},
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
		"florentc/vim-tla",
		ft = { "tla" },
	},
}
