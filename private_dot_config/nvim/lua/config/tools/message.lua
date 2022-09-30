-- See <https://github.com/AckslD/messages.nvim>

require("messages").setup({
	prepare_buffer = function(opts)
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_option(buf, "filetype", "messages_capture")
		return vim.api.nvim_open_win(buf, true, opts)
	end,
})

Messages = function(...)
	require("messages.api").capture_thing(...)
end
