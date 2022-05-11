-- See <https://github.com/t-troebst/perfanno.nvim>

local perfanno = require("perfanno")
local util = require("perfanno.util")

perfanno.setup({
	line_highlights = util.make_bg_highlights("#333300", "#FF3300", 4),
	vt_highlight = util.make_fg_highlight("#CC3300"),
})
