local L = function(mod)
	return require("keymaps.langs." .. mod)
end

L("cmp")
L("lsp")
L("treesitter")
