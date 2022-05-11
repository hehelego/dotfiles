require("which-key").register({
	name = "finder",
	["f"] = { "<cmd>Telescope find_files<cr>", "files" },
	["F"] = { "<cmd>Telescope find_files hidden=true ignore=true<cr>", "files-hidden" },
	["c"] = { "<cmd>Telescope quickfix<cr>", "quickfix" },
	["l"] = { "<cmd>Telescope loclist<cr>", "loclist" },
	["b"] = { "<cmd>Telescope buffers<cr>", "buffers" },
	["g"] = { "<cmd>Telescope live_grep<cr>", "live-grep" },
	["h"] = { "<cmd>Telescope oldfiles<cr>", "recent-files" },
	["d"] = { "<cmd>Telescope diagnostics<cr>", "diagnostics" },
	["."] = { "<cmd>Telescope builtin include_extensions=true<cr>", "finders" },
	-- It is not encouraged to use following keymaps.
	-- Instead use `<leader>f.` and search for the function you want.
	-- Typing `/ ? :` are quite difficult, causing delay and strain
	["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "search-text" },
	["?"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "search-text" },
	[":"] = { "<cmd>Telescope commands<cr>", "commands" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>f",
})
