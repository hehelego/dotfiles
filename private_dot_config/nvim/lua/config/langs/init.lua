local function L(mod)
	return require("config.langs." .. mod)
end

L("mason")
L("cmp")
L("lsp")
L("treesitter")
