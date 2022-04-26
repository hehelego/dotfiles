local function L(mod)
	return require("config.langs." .. mod)
end

L("cmp")
L("lsp")
L("treesitter")
