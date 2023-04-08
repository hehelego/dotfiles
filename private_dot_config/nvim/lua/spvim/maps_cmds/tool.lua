local reg = require("which-key").register

reg({
	name = "finder",
	["f"] = { "<cmd>Telescope find_files<cr>", "files" },
	["F"] = { "<cmd>Telescope find_files hidden=true ignore=true<cr>", "files-hidden" },
	["c"] = { "<cmd>Telescope quickfix<cr>", "quickfix" },
	["l"] = { "<cmd>Telescope loclist<cr>", "loclist" },
	["b"] = { "<cmd>Telescope buffers<cr>", "buffers" },
	["g"] = { "<cmd>Telescope live_grep<cr>", "live-grep" },
	["h"] = { "<cmd>Telescope oldfiles<cr>", "recent-files" },
	["."] = { "<cmd>Telescope builtin include_extensions=true<cr>", "finders" },
	[":"] = { "<cmd>Telescope commands<cr>", "commands" },
	["/"] = { "<cmd>Telescope current_buffer_fuzzy_find skip_empty_lines=true<cr>", "commands" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>f",
})

reg({
	["z"] = { "<cmd>Telescope zoxide list<cr>", "zoxide" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>",
})

reg({
	name = "finder-help",
	h = { "<cmd>Telescope help_tags<cr>", "help-tags" },
	m = { "<cmd>Telescope man_pages sections=ALL<cr>", "man-pages" },
}, { mode = "n", silent = true, noremap = true, prefix = "<leader>h" })

reg({
	name = "trouble.list",
	r = { "<cmd>TroubleRefresh<cr>", "trouble.list refresh" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "trouble.list diagnostic" },
	D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "trouble.list diagnostic-ws" },
	c = { "<cmd>TroubleToggle quickfix<cr>", "trouble.list quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "trouble.list quickfix" },
}, { mode = "n", silent = true, noremap = true, prefix = "<leader>l" })

vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", {
	silent = true,
	noremap = true,
	desc = "next git diff hunk",
})
vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", {
	silent = true,
	noremap = true,
	desc = "previous git diff hunk",
})

reg({
	name = "git",
	["f"] = { "<cmd>Telescope git_files<CR>", "tracked-files" },
	["s"] = { "<cmd>Telescope git_status<CR>", "status" },
	["S"] = { "<cmd>Telescope git_stash<CR>", "stash" },
	["b"] = { "<cmd>Telescope git_branches<CR>", "branches" },
	["c"] = { "<cmd>Telescope git_commits<CR>", "commits" },
	["C"] = { "<cmd>Telescope git_bcommits<CR>", "commits-buffer" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>g",
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {
	desc = "toggle nvim-tree file explorer",
	silent = true,
	noremap = true,
})
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFileToggle<cr>", {
	desc = "toggle nvim-tree file explorer",
	silent = true,
	noremap = true,
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<cr>", {
	desc = "toggle aerial symbol tree",
	silent = true,
	noremap = true,
})
