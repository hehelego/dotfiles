local reg = require("which-key").register

-- u/U for undo/redo
vim.keymap.set("n", "u", "<cmd>:undo<cr>", {
	silent = true,
	noremap = true,
	desc = "undo one change",
})
vim.keymap.set("n", "U", "<cmd>:redo<cr>", {
	silent = true,
	noremap = true,
	desc = "undo one change",
})

reg({
	name = "quickfix",
	o = { "<cmd>copen<cr>", "open" },
	c = { "<cmd>cclose<cr>", "close" },
	n = { "<cmd>cnext<cr>", "next" },
	p = { "<cmd>cprevious<cr>", "prev" },
}, { mode = "n", slient = true, noremap = true, prefix = "<leader>c" })
reg({
	name = "loclist",
	o = { "<cmd>lopen<cr>", "open" },
	c = { "<cmd>lclose<cr>", "close" },
	n = { "<cmd>lnext<cr>", "next" },
	p = { "<cmd>lprevious<cr>", "prev" },
}, { mode = "n", silent = true, noremap = true, prefix = "<leader>l" })

local window_keys = {
	-- focus another window
	"h",
	"j",
	"k",
	"l",
	-- move focused window
	"H",
	"J",
	"K",
	"L",
	"T",
	-- close or quit the focused window
	"c",
	"q",
	"o",
	-- increase or decrease height
	"+",
	"-",
	-- increase or decrease width
	"r",
	"<",
	">",
	-- make the windows have equal size
	"=",
}
-- Use <Alt> instead of <C-w> for window prefix
for _, k in ipairs(window_keys) do
	local lhs = string.format("<M-%s>", k)
	local rhs = string.format("<C-w>%s", k)
	vim.keymap.set("n", lhs, rhs, {
		silent = true,
		noremap = true,
		desc = "windows manipulation keymaps",
	})
end

reg({
	name = "buffer",
	d = { "<cmd>bdelete<cr>", "delete" },
	n = { "<cmd>bnext<cr>", "next" },
	p = { "<cmd>bprevious<cr>", "prev" },
}, { mode = "n", silent = true, noremap = true, prefix = "<leader>b" })

reg({
	name = "help",
	f = { ":Telescope help_tags<cr>", "help-tags" },
	h = { ":Telescope help_tags<cr>", "help-tags" },
	m = { ":Telescope man_pages sections=ALL<cr>", "man-pages" },
	c = { ":helpclose<cr>", "close" },
	["/"] = { ":helpgrep ", "grep", silent = false },
}, { mode = "n", silent = true, noremap = true, prefix = "<leader>h" })

local ft_quit_grp = vim.api.nvim_create_augroup("ft_quick_quit", {})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "qf", "man", "lspinfo" },
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			silent = false,
			noremap = true,
			buffer = args.buf,
			desc = "press [q] to quit",
		})
	end,
	desc = "press [q] to quit in help/man/qf",
	group = ft_quit_grp,
})
