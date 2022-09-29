-- The nightfox colorscheme
-- See <https://github.com/EdenEast/nightfox.nvim>
require("nightfox").setup({
	options = {
		-- Style to be applied to different syntax groups. See :help attr-list
		styles = {
			comments = "italic",
			conditionals = "NONE",
			constants = "NONE",
			functions = "NONE",
			keywords = "NONE",
			numbers = "NONE",
			operators = "NONE",
			strings = "NONE",
			types = "NONE",
			variables = "NONE",
		},
		-- transparent backgroud
		transparent = false,
	},
})
-- setup must be called before loading
vim.cmd("colorscheme nightfox")
