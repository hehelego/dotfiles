-- see https://github.com/phaazon/hop.nvim
-- see https://github.com/easymotion/vim-easymotion
local hop = require('hop')

local opts = {
  keys = 'asdghklqwertyuiopzxcvbnmfj',
  quit_key = '<Esc>',
  case_insensitive = true,
  jump_on_sole_occurrence = false,
  multi_windows = false,
  teasing = true,
}

hop.setup(opts)
