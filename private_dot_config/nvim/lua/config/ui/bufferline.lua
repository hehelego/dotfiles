-- See <https://github.com/akinsho/bufferline.nvim>
local conf = {
	mode = "buffers", -- set to "tabs" to only show tabpages instead
	numbers = "none",
	close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
	left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
	indicator_icon = "▎",
	buffer_close_icon = "",
	modified_icon = "●",
	close_icon = "",
	left_trunc_marker = "",
	right_trunc_marker = "",
	max_name_length = 18,
	max_prefix_length = 15,
	tab_size = 18,
	diagnostics = false,
	-- do not overlap with NvimTree file explorer and Aerial symbol tree
	offsets = {
		{ filetype = "NvimTree", text = "File Explorer" },
		{ filetype = "aerial", text = "Symbol Tree" },
	},
	color_icons = true, -- whether or not to add the filetype icon highlights
	show_buffer_icons = true,
	show_buffer_close_icons = true,
	show_buffer_default_icon = true,
	show_close_icon = true,
	show_tab_indicators = true,
	persist_buffer_sort = true,
	enforce_regular_tabs = true,
	always_show_bufferline = true,

	custom_filter = function(buf, buf_nums)
		local _ = buf_nums -- discard the buf_nums argument
		local appear = true
		local ft = vim.bo[buf].filetype
		local ignore_ft = {
			"qf",
		}
		for _, v in ipairs(ignore_ft) do
			if ft == v then
				appear = false
			end
		end
		return appear
	end,
}

require("bufferline").setup({
	options = conf,
})
