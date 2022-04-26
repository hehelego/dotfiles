-- See <https://github.com/goolord/alpha-nvim>

local alpha = require("alpha")

local dashboard = require("alpha.themes.dashboard")
dashboard.section.buttons.val = {
	dashboard.button("e", "  New empty file", ":enew<CR>"),
	dashboard.button("f", "  Find files", ":Telescope find_files<CR>"),
	dashboard.button("F", "  Find files all", ":Telescope find_files hidden=true<CR>"),
	dashboard.button("t", "  File explorer", ":NvimTreeFocus<CR>"),
	dashboard.button("h", "  File history", ":Telescope oldfiles<CR>"),
	dashboard.button("g", "  Search live grep", ":Telescope live_grep<CR>"),
	dashboard.button("z", "  Zoxide cd", ":Telescope zoxide list<CR>"),
	dashboard.button(".", "  Edit nvim config", ":edit ~/.config/nvim/<CR>"),
	dashboard.button("?", "ﲉ  Search help pages", ":Telescope help_tags<CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
