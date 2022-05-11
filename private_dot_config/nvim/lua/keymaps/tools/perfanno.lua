require("which-key").register({
	name = "perf",
	["l"] = {
		name = "load",
		["f"] = { "<cmd>:PerfLoadFlat<cr>", "flat" },
		["g"] = { "<cmd>:PerfLoadCallGraph<cr>", "call-graph" },
		["o"] = { "<cmd>:PerfLoadFlameGraph<cr>", "flame-graph" },
	},
	["e"] = { "<cmd>PerfPickEvent<cr>", "pick-event" },
	["t"] = { "<cmd>PerfToggleAnnotations<cr>", "toggle" },
	["a"] = { "<cmd>PerfAnnotate<cr>", "annotate" },
	["f"] = { "<cmd>PerfAnnotateFunction<cr>", "annotate-func" },
	["h"] = { "<cmd>PerfHottestLines<cr>", "hot-line" },
	["s"] = { "<cmd>PerfHottestSymbols<cr>", "hot-symbol" },
	["c"] = { "<cmd>PerfHottestCallersFunction<cr>", "hot-caller" },
}, {
	mode = "n",
	noremap = true,
	silent = true,
	prefix = "<leader>p",
})

vim.keymap.set({ "x", "v" }, "<leader>pa", "<cmd>PerfAnnotateSelection<cr>", {
	noremap = true,
	silent = true,
	desc = "annotate-selection",
})
