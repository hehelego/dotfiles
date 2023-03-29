-- See <https://github.com/nvim-lualine/lualine.nvim>
require("lualine").setup({
	options = {
		theme = "nightfox",
		globalstatus = true,
	},
	extensions = {
		"aerial",
		"fzf",
		"man",
		"nvim-dap-ui",
		"nvim-tree",
		"quickfix",
		"toggleterm",
	},
})
