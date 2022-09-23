local function L(mod)
	return require("config.langs." .. mod)
end

L("mason")
L("lsp")
L("treesitter")
L("cmp")
