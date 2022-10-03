vim.g.treesitter_status = false

local ts_mods = {
	"highlight",
	"incremental_selection",
	"indent",
	"rainbow",
}

local function ts_open()
	vim.g.treesitter_status = true

	for _, mod in ipairs(ts_mods) do
		vim.cmd(string.format("TSEnable %s", mod))
	end
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

local function ts_close()
	vim.g.treesitter_status = false
	for _, mod in ipairs(ts_mods) do
		vim.cmd(string.format("TSDisable %s", mod))
	end
	vim.opt.foldmethod = "indent" -- sync with foldmethod in base/vim-opt.lua
end

local function ts_toggle()
	if vim.g.treesitter_status == true then
		ts_close()
	else
		ts_open()
	end
end

vim.api.nvim_create_user_command("TsOpen", ts_open, {})
vim.api.nvim_create_user_command("TsClose", ts_close, {})
vim.api.nvim_create_user_command("TsToggle", ts_toggle, {})

-- see config.langs.treesitter for the commands
require("which-key").register({
	name = "treesitter",
	["o"] = { "<cmd>TsOpen<cr>", "treesitter on" },
	["c"] = { "<cmd>TsClose<cr>", "treesitter off" },
	["s"] = { "<cmd>TsToggle<cr>", "treesitter toggle" },
	["p"] = { "<cmd>TSPlaygroundToggle<cr>", "ts playground toggle" },
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = "<leader>s",
})
