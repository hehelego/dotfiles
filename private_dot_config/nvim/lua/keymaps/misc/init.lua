local wk = require("which-key")

wk.register({
	["z"] = { "<cmd>Telescope zoxide list<cr>", "zoxide" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>",
})

local function toggle_conceal()
	if vim.opt.conceallevel:get() > 0 then
		vim.opt.conceallevel = 0
	else
		vim.opt.conceallevel = 2
	end
end

wk.register({
	["p"] = { toggle_conceal, "conceal" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>",
})

wk.register({
	["l"] = { "vimtex" },
}, {
	mode = "n",
	prefix = "<localleader>",
})
