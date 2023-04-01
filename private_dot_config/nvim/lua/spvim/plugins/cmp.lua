return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					local cmp = require("cmp")
					local luasnip = require("luasnip")
					local lspkind = require("lspkind")

					-- load snippets for luasnip
					require("luasnip.loaders.from_vscode").lazy_load()

					local cmp_keymaps = {
						-- Ctrl-Space to trigger completion
						["<C-Space>"] = cmp.mapping.complete(),
						-- Return to confirm completion
						["<CR>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.confirm({ select = true })
							else
								fallback()
							end
						end),
						["<C-p>"] = cmp.mapping.select_prev_item(),
						["<C-n>"] = cmp.mapping.select_next_item(),
						["<C-d>"] = cmp.mapping.scroll_docs(4),
						["<C-u>"] = cmp.mapping.scroll_docs(-4),
						["<C-e>"] = cmp.mapping.abort(),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.jumpable(1) then
								luasnip.jump(1)
							else
								fallback()
							end
						end, { "i", "s" }),
						-- Shift-Tab: prev option | prev snippet slot | fallback
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}

					vim.opt.timeoutlen:get()

					cmp.setup({
						-- prevent legging/bouncing
						performance = {
							debounce = vim.opt.timeoutlen:get(),
							throttle = 30,
							fetching_timeout = 100,
						},
						-- snippet options
						snippet = {
							expand = function(args)
								require("luasnip").lsp_expand(args.body)
							end,
						},
						-- completion menu
						mapping = cmp.mapping.preset.insert(cmp_keymaps),
						-- completion menu item formatter
						formatting = {
							format = lspkind.cmp_format({
								mode = "symbol_text",
								menu = {
									nvim_lsp = "[lsp]",
									luasnip = "[snippet]",
									nvim_lua = "[nvim-lua]",
									path = "[path]",
									buffer = "[buffer]",
									omni = "[omni]",
								},
							}),
						},
						-- installed sources
						sources = {
							{ name = "nvim_lsp" },
							{ name = "nvim_lua" },
							{ name = "luasnip" },
							{ name = "buffer" },
							{ name = "path" },
						},
					})

					cmp.setup.cmdline("/", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = { { name = "buffer" } },
					})
					cmp.setup.cmdline("?", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = { { name = "buffer" } },
					})
					cmp.setup.cmdline(":", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = {
							{ name = "path" },
							{
								name = "cmdline",
								option = {
									-- cmp-nvim disable completion for `:Man` and `!<shell command>` by default
									-- we want to enable them
									ignore_cmds = {},
								},
							},
						},
					})
					cmp.setup.filetype("tex", {
						sources = {
							{ name = "omni" },
							{ name = "luasnip" },
							{ name = "buffer" },
							{ name = "path" },
						},
					})
				end,
			},
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-omni",
		},
	},
}
