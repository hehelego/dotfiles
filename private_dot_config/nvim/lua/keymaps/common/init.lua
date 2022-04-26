local reg = require("which-key").register

reg({
	name = "quickfix",
	o = { "<cmd>copen<cr>", "open" },
	c = { "<cmd>cclose<cr>", "close" },
	n = { "<cmd>cnext<cr>", "next" },
	p = { "<cmd>cprevious<cr>", "prev" },
}, { mode = "n", prefix = "<leader>c" })
reg({
	name = "loclist",
	o = { "<cmd>lopen<cr>", "open" },
	c = { "<cmd>lclose<cr>", "close" },
	n = { "<cmd>lnext<cr>", "next" },
	p = { "<cmd>lprevious<cr>", "prev" },
}, { mode = "n", prefix = "<leader>l" })

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
	-- make the windows have equal size
	"=",
}
for _, k in ipairs(window_keys) do
	vim.keymap.set("n", "<M-" .. k .. ">", "<C-w>" .. k)
end

reg({
	name = "buffer",
	d = { "<cmd>bdelete<cr>", "delete" },
	n = { "<cmd>bnext<cr>", "next" },
	p = { "<cmd>bprevious<cr>", "prev" },
}, { mode = "n", prefix = "<leader>b" })

reg({
	name = "help",
	f = { ":Telescope help_tags<cr>", "help-tags" },
	h = { ":Telescope help_tags<cr>", "help-tags" },
	m = { ":Telescope man_pages sections=ALL<cr>", "man-pages" },
	c = { ":helpclose<cr>", "close" },
	["/"] = { ":helpgrep ", "grep", silent = false },
}, { mode = "n", prefix = "<leader>h" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>helpclose<cr>", { silent = false, buffer = args.buf })
	end,
	desc = "press [q] to quit help page",
	group = vim.api.nvim_create_augroup("help_quick_quit", { clear = false }),
})
