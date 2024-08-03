local reg = require("which-key").register

-- u/U for undo/redo
vim.keymap.set("n", "u", "<cmd>:undo<cr>", {
	silent = true,
	desc = "undo one change",
})
-- u/U for undo/redo
vim.keymap.set("n", "U", "<cmd>:redo<cr>", {
	silent = true,
	desc = "redo one change",
})

-- dh/dl to delete half line
vim.keymap.set("n", "dh", "d^", {
	silent = true,
	desc = "delete the half line before cursor",
})
-- dh/dl to delete half line
vim.keymap.set("n", "dl", "d$", {
	silent = true,
	desc = "delete the half line after cursor",
})

-- yh/yl to yank half line
vim.keymap.set("n", "yh", "y^", {
	silent = true,
	desc = "yank the half line before cursor",
})
vim.keymap.set("n", "yl", "y$", {
	silent = true,
	desc = "yank the half line after cursor",
})

-- using system clipboard
vim.keymap.set({ "n", "v", "x" }, "gy", [["+y]], {
	silent = true,
	desc = "use system clipboard copy",
})
vim.keymap.set({ "n", "v", "x" }, "gp", [["+p]], {
	silent = true,
	desc = "use system clipboard paste",
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
		desc = "use alt+hjkl to move cursor",
	})
end

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
	"r",
	-- close or quit the focused window
	"c",
	"q",
	"o",
}
-- Use <Alt> instead of <C-w> for window prefix
for _, k in ipairs(window_keys) do
	local lhs = string.format("<M-%s>", k)
	local rhs = string.format("<C-w>%s", k)
	vim.keymap.set("n", lhs, rhs, {
		silent = true,
		desc = string.format("windows %s", rhs),
	})
end
-- window resize with "-=,." for "-+<>"
for s, t in pairs({ ["-"] = "-", ["="] = "+", [","] = "<", ["."] = ">" }) do
	local lhs = string.format("<M-%s>", s)
	local rhs = string.format("<C-w>%s", t)
	vim.keymap.set("n", lhs, rhs, {
		silent = true,
		desc = string.format("windows %s", rhs),
	})
end

for i = 1, 9 do
	vim.keymap.set("n", string.format("<M-%d>", i), string.format("<cmd>LualineBuffersJump! %d<cr>", i), {
		silent = true,
		desc = "switch buffer",
	})
end

local buffer_maps = {
	d = { rhs = "<cmd>Bdelete<cr>", desc = "delete" },
	w = { rhs = "<cmd>Bwipeout<cr>", desc = "wipeout" },
	n = { rhs = "<cmd>bnext<cr>", desc = "next" },
	p = { rhs = "<cmd>bprevious<cr>", desc = "prev" },
}
for lhs, v in pairs(buffer_maps) do
	vim.keymap.set("n", "<leader>b" .. lhs, v.rhs, {
		silent = true,
		desc = v.desc,
	})
end

local ft_quit_grp = vim.api.nvim_create_augroup("ft_quick_quit", {})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "qf", "man", "lspinfo", "mason" },
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			silent = false,
			buffer = args.buf,
			desc = "press [q] to quit",
		})
	end,
	desc = "press [q] to quit in help/man/qf",
	group = ft_quit_grp,
})

local function toggle_conceal()
	if vim.opt.conceallevel:get() > 0 then
		vim.opt.conceallevel = 0
	else
		vim.opt.conceallevel = 2
	end
end
vim.keymap.set("n", "<leader>p", toggle_conceal, {
	silent = true,
	desc = "toggle-conceal",
})

reg({
	name = "diff",
	["d"] = { "<cmd>diffthis<cr>", "on" },
	["D"] = { "<cmd>diffoff<cr>", "off" },
	["o"] = { "<cmd>diffget<cr>", "get" },
	["p"] = { "<cmd>diffput<cr>", "put" },
}, {
	mode = "n",
	silent = true,
	prefix = "<leader>d",
})
