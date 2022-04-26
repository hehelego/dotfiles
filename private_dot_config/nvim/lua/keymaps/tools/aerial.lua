local reg = require("which-key").register

reg({
	name = "aerial",
	["a"] = { "<cmd>AerialToggle<cr>", "toggle" },
	["o"] = { "<cmd>AerialOpen<cr>", "open" },
	["c"] = { "<cmd>AerialClose<cr>", "close" },
}, { mode = "n", prefix = "<leader>a", silent = true })
