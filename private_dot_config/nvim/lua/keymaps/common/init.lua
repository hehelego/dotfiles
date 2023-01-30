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

-- dh/dl to delete half line
vim.keymap.set("n", "dh", "d^", {
	silent = true,
	noremap = true,
	desc = "delete the half line before cursor",
})
vim.keymap.set("n", "dl", "d$", {
	silent = true,
	noremap = true,
	desc = "delete the half line after cursor",
})

-- yh/yl to yank half line
vim.keymap.set("n", "yh", "y^", {
	silent = true,
	noremap = true,
	desc = "yank the half line before cursor",
})
vim.keymap.set("n", "yl", "y$", {
	silent = true,
	noremap = true,
	desc = "yank the half line after cursor",
})

-- using system clipboard
vim.keymap.set({ "i", "c" }, "<M-V>", [[eval('@+')]], {
	silent = true,
	noremap = true,
	expr = true,
	desc = "(insert) use system clipboard paste",
})
vim.keymap.set({ "v", "x" }, "<M-C>", [["+y]], {
	silent = true,
	noremap = true,
	desc = "use system clipboard copy",
})
vim.keymap.set({ "v", "x" }, "<M-V>", [["+p]], {
	silent = true,
	noremap = true,
	desc = "use system clipboard paste",
})
vim.keymap.set({ "v", "x" }, "<M-X>", [["+d]], {
	silent = true,
	noremap = true,
	desc = "use system clipboard cut",
})

-- move cursor in insert mode and command-line mode
local direction_keys = {
	{ "<M-h>", "<left>" },
	{ "<M-j>", "<down>" },
	{ "<M-k>", "<up>" },
	{ "<M-l>", "<right>" },
}
for _, km in ipairs(direction_keys) do
	vim.keymap.set({ "i", "c" }, km[1], km[2], {
		silent = true,
		noremap = true,
		desc = "use alt+hjkl to move cursor",
	})
end

reg({
	name = "quickfix",
	o = { "<cmd>copen<cr>", "open" },
	c = { "<cmd>cclose<cr>", "close" },
	n = { "<cmd>cnext<cr>", "next" },
	p = { "<cmd>cprevious<cr>", "prev" },
}, { mode = "n", silent = true, noremap = true, prefix = "<leader>c" })
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
	pattern = { "help", "qf", "man", "lspinfo", "mason" },
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
