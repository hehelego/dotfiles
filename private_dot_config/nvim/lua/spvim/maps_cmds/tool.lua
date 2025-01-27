local wk = require("which-key")

-- telescope
wk.add({
	{ "<leader>f", group = "finder" },
	-- text search
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "live-grep" },
	{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find skip_empty_lines=true<cr>", desc = "text" },
	-- files
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "files" },
	{ "<leader>fF", "<cmd>Telescope find_files hidden=true ignore=true<cr>", desc = "files-hidden" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "buffers" },
	{ "<leader>fh", "<cmd>Telescope oldfiles<cr>", desc = "recent-files" },
	-- quickfix and location list
	{ "<leader>fc", "<cmd>Telescope quickfix<cr>", desc = "quickfix" },
	{ "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "loclist" },
	-- misc
	{ "<leader>f.", "<cmd>Telescope builtin include_extensions=true<cr>", desc = "finders" },
	{ "<leader>f:", "<cmd>Telescope commands<cr>", desc = "commands" },
	{ "<leader>fm", "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
	-- help search
	{ "<leader>h", group = "help" },
	{ "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "help-tags" },
	{ "<leader>hm", "<cmd>Telescope man_pages sections=ALL<cr>", desc = "man-pages" },
})

-- aerial symbol tree
wk.add({
	{ "<leader>a", group = "aerial-toc" },
	{ "<leader>aa", "<cmd>AerialToggle<cr>", desc = "toggle" },
	{ "<leader>af", "<cmd>Telescope aerial<cr>", desc = "telescope-jump" },
	{ "<leader>ar", require("aerial").refetch_symbols, desc = "refresh" },
})

-- trouble list
wk.add({
	{ "<leader>q", group = "trouble.list" },
	-- diagnostics
	{ "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "diagnostic(buf)" },
	{ "<leader>qD", "<cmd>Trouble diagnostics toggle <cr>", desc = "diagnostic(ws)" },
	-- qf and loc
	{ "<leader>qc", "<cmd>Trouble qflist toggle <cr>", desc = "quickfix" },
	{ "<leader>ql", "<cmd>Trouble loclist toggle <cr>", desc = "loclist" },
	-- misc
	{ "<leader>qs", "<cmd>Trouble symbols toggle <cr>", desc = "symbols" },
	{ "<leader>qt", "<cmd>Trouble todo toggle <cr>", desc = "todo" },
})

-- zoxide & change directory
wk.add({
	{ "<leader>z", group = "change-dir" },
	{ "<leader>zz", "<cmd>Telescope zoxide list<cr>", desc = "zoxide" },
	{ "<leader>z.", "<cmd>cd %:h<cr>", desc = "buf-dir" },
})

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "[q", function()
	local trouble = require("trouble")
	if trouble.is_open() then
		trouble.previous({ skip_groups = true, jump = true })
	else
		local ok, _ = pcall(vim.cmd.cprev)
		if not ok then
			vim.cmd.echo('"cprev: no previous item"')
		end
	end
end, {
	silent = true,
	desc = "Previous trouble/quickfix item",
})
vim.keymap.set("n", "]q", function()
	local trouble = require("trouble")
	if trouble.is_open() then
		trouble.next({ skip_groups = true, jump = true })
	else
		local ok, _ = pcall(vim.cmd.cnext)
		if not ok then
			vim.cmd.echo('"cnext: no next item"')
		end
	end
end, {
	silent = true,
	desc = "Next trouble/quickfix item",
})

vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", {
	silent = true,
	desc = "next git diff hunk",
})
vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", {
	silent = true,
	desc = "previous git diff hunk",
})

-- git integration
local gitsigns = require("gitsigns")

wk.add({
	{ "<leader>g", group = "git" },
	{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },
	{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
	{ "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "commits buf" },
	{ "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "stash" },
	{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "branches" },
	{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "tracked-files" },
	-- neogit
	{ "<leader>gg", "<cmd>Neogit<cr>", desc = "neogit" },
	-- gitsigns hunk actions
	{ "<leader>gh", group = "gitsigns hunk" },
	-- Actions
	{ "<leader>ghs", gitsigns.stage_hunk, desc = "stage hunk" },
	{
		"<leader>ghs",
		function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end,
		desc = "stage hunk",
		mode = "v",
	},
	{ "<leader>ghr", gitsigns.reset_hunk, desc = "reset hunk" },
	{
		"<leader>ghr",
		function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end,
		desc = "reset hunk",
		mode = "v",
	},
	{ "<leader>ghu", gitsigns.undo_stage_hunk, desc = "undo stage hunk" },
	{ "<leader>ghp", gitsigns.preview_hunk, desc = "prefix hunk" },
	{
		"<leader>ghb",
		function()
			gitsigns.blame_line({ full = true })
		end,
		desc = "blame",
	},
	{ "<leader>ghd", gitsigns.diffthis, desc = "diff-index" },
	{
		"<leader>hD",
		function()
			gitsigns.diffthis("~")
		end,
		desc = "diff-commit(~)",
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {
	desc = "nvim-tree",
	silent = true,
})
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFileToggle<cr>", {
	desc = "nvim-tree",
	silent = true,
})

-- zk-nvim
wk.add({
	{ "<leader>k", group = "zettelkasten" },
	{ "<leader>kf", "<cmd>ZkNotes<cr>", desc = "find notes" },
	{ "<leader>kg", ":'<,'>ZkMatch<cr>", desc = "search note text", mode = "v" },
	{ "<leader>kt", "<cmd>ZkTags<cr>", desc = "note tags" },
	{ "<leader>kl", "<cmd>ZkLinks<cr>", desc = "outgoing link" },
	{ "<leader>kj", "<cmd>ZkBacklinks<cr>", desc = "back jumping links" },
})
