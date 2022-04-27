-- See <https://github.com/neovim/nvim-lspconfig>
-- See <https://github.com/williamboman/nvim-lsp-installer>
--
-- Crediit https://github.com/ayamir/nvimdots/blob/main/lua/modules/completion/config.lua
-- Crediit https://github.com/LunarVim/Neovim-from-scratch/tree/master/lua/user/lsp

local function L(mod)
	return require("config.langs.lsp." .. mod)
end

L("setup")
L("null-ls")
L("lightbulb")
