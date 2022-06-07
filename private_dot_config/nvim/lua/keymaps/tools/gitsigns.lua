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

require("which-key").register({
	name = "git",
	["h"] = { "<cmd>Gitsigns setqflist<cr>", "qf-hunks" },
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

-- for hunk actions (reest/blame,diff), use code-actions <leader>a
-- see config.langs.lsp.null-ls
