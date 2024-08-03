local function bind(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, {
		silent = true,
		desc = desc,
	})
end

bind({ "n", "x", "o" }, "<localleader>f", "<Plug>(leap-forward-to)", "Leap forward to")
bind({ "n", "x", "o" }, "<localleader>F", "<Plug>(leap-backward-to)", "Leap backward to")
bind({ "n", "x", "o" }, "<localleader>s", "<Plug>(leap-forward-to)", "Leap forward to")
bind({ "n", "x", "o" }, "<localleader>S", "<Plug>(leap-backward-to)", "Leap backward to")
bind({ "n", "x", "o" }, "<localleader>x", "<Plug>(leap-forward-till)", "Leap forward till")
bind({ "n", "x", "o" }, "<localleader>X", "<Plug>(leap-backward-till)", "Leap backward till")

bind({ "n", "x", "o" }, "<localleader>gs", "<Plug>(leap-from-window)", "Leap from window")

bind({ "n", "x", "o" }, "<localleader><localleader>", function()
	local current_window = vim.fn.win_getid()
	require("leap").leap({ target_windows = { current_window } })
end, "Leap forward+backward")
