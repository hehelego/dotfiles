-- See <https://github.com/AckslD/messages.nvim>

require("messages").setup()

Messages = function(...)
	require("messages.api").capture_thing(...)
end
