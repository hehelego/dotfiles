-- See <https://github.com/L3MON4D3/LuaSnip>
-- See <https://github.com/hrsh7th/nvim-cmp>
--
-- Credit <https://github.com/ayamir/nvimdots/blob/main/lua/modules/completion/config.lua>
-- Credit <https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/cmp.lua>
-- Credit <https://github.com/t-troebst/config.nvim/blob/master/lua/user/completion.lua>

local lspkind = require("lspkind")
local luasnip = require("luasnip")
-- load snippets for luasnip
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local cmp_keymaps = {
	-- Ctrl-Space to trigger completion
	["<C-Space>"] = cmp.mapping.complete(),
	-- Return to confirm completion
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	--  navigating the completion menu
	["<C-d>"] = cmp.mapping.scroll_docs(4),
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-p>"] = cmp.mapping.select_prev_item(),
	["<C-n>"] = cmp.mapping.select_next_item(),
	-- Ctrl-e to abort completion
	["<C-e>"] = cmp.mapping.abort(),
	-- Tab: next option | next snippet slot | fallback
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

cmp.setup({
	-- disable auto-completion while typing, see function DebounceCMP
	completion = {
		autocomplete = false,
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	-- completion menu
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert(cmp_keymaps),
	-- completion menu item formatter
	formatting = {
		format = lspkind.cmp_format({
			-- show only symbol annotations
			mode = "symbol_text",
			-- prevent the popup from showing more than provided characters
			maxwidth = 50,
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
		{ name = "cmdline" },
	},
})

-- See <https://github.com/hrsh7th/nvim-cmp/issues/598>
local delay = vim.opt.timeoutlen:get()
local timer = vim.loop.new_timer()
local function debounce()
	timer:stop()
	timer:start(
		delay,
		0,
		vim.schedule_wrap(function()
			cmp.complete({ reason = cmp.ContextReason.Auto })
		end)
	)
end

local cmp_debounce_grp = vim.api.nvim_create_augroup("cmp_debounce", {})
vim.api.nvim_create_autocmd({ "TextChangedI", "CmdlineChanged" }, {
	pattern = "*",
	callback = debounce,
	group = cmp_debounce_grp,
	desc = "nvim-cmp auto-completion debounce",
})
