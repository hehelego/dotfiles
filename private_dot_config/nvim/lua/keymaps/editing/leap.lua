-- See <https://github.com/ggandor/leap.nvim>

local function bind(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, {
		silent = true,
		noremap = true,
		desc = desc,
	})
end

bind({ "n", "x", "o" }, "<localleader>f", "<Plug>(leap-forward-to)", "Leap forward to")
bind({ "n", "x", "o" }, "<localleader>s", "<Plug>(leap-forward-to)", "Leap forward to")
bind({ "x", "o" }, "<localleader>x", "<Plug>(leap-forward-till)", "Leap forward till")
bind({ "n", "x", "o" }, "<localleader>S", "<Plug>(leap-backward-to)", "Leap backward to")
bind({ "x", "o" }, "<localleader>X", "<Plug>(leap-backward-till)", "Leap backward till")
bind({ "n", "x", "o" }, "<localleader>gs", "<Plug>(leap-from-window)", "Leap from window")
