-- See <https://github.com/phaazon/hop.nvim>
-- See <https://github.com/ggandor/lightspeed.nvim>
-- See <https://github.com/easymotion/vim-easymotion>
require("hop").setup({
	keys = "asdghklqwertyuiopzxcvbnmfj",
	quit_key = "<Esc>",
	case_insensitive = true,
	jump_on_sole_occurrence = false,
	inclusive_jump = false,
	multi_windows = false,
	teasing = true,
})
