local confs = {}

vim.list_extend(confs, require("spvim.plugins.common"))
vim.list_extend(confs, require("spvim.plugins.edit"))
vim.list_extend(confs, require("spvim.plugins.tool"))
vim.list_extend(confs, require("spvim.plugins.ui"))
vim.list_extend(confs, require("spvim.plugins.cmp"))
vim.list_extend(confs, require("spvim.plugins.lsp"))
vim.list_extend(confs, require("spvim.plugins.treesitter"))
vim.list_extend(confs, require("spvim.plugins.extra"))

return confs
