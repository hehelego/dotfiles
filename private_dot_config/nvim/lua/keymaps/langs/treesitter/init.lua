local reg = require("which-key").register

-- see config.langs.treesitter for the commands
reg({
	name = 'treesitter',
	["o"] = {"<cmd>TSon<cr>", "on"},
	["c"] = {"<cmd>TSoff<cr>", "off"},
	["s"] = {"<cmd>TStoggle<cr>", "toggle"},
},{mode='n',prefix='<leader>s',silent=true})
