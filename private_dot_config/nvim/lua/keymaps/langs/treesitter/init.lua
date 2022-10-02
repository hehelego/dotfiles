vim.g.treesitter_status = false

local ts_mods = {
	"highlight",
	"rainbow",
	"indent",
}

local function ts_on()
	vim.g.treesitter_status = true

	for _, mod in ipairs(ts_mods) do
		vim.cmd(string.format("TSEnable %s", mod))
	end

	vim.opt.syntax = "off"
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end
local function ts_off()
	vim.g.treesitter_status = false
	for _, mod in ipairs(ts_mods) do
		vim.cmd(string.format("TSDisable %s", mod))
	end
	vim.opt.syntax = "on"
	vim.opt.foldmethod = require('base/vim-opt').foldmethod
end
local function ts_toggle()
	if vim.g.treesitter_status == true then
		ts_off()
	else
		ts_on()
	end
end

vim.api.nvim_create_user_command("TSon", ts_on, {})
vim.api.nvim_create_user_command("TSoff", ts_off, {})
vim.api.nvim_create_user_command("TStoggle", ts_toggle, {})

-- see config.langs.treesitter for the commands
require("which-key").register({
	name = "treesitter",
	["o"] = { "<cmd>TSon<cr>", "on" },
	["c"] = { "<cmd>TSoff<cr>", "off" },
	["s"] = { "<cmd>TStoggle<cr>", "toggle" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>s",
})
