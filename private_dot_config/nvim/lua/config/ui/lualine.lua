-- See <https://github.com/nvim-lualine/lualine.nvim>
require("lualine").setup({
	options = {
		globalstatus = true,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
})
