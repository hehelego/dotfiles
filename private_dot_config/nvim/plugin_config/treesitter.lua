-- see https://github.com/nvim-treesitter/nvim-treesitter
-- see https://github.com/p00f/nvim-ts-rainbow
-- see https://github.com/nvim-treesitter/playground
local ts = require('nvim-treesitter.configs')

local ts_opts = {
  ensure_installed = {
    -- general purpose programming
    'c',
    'cpp',
    'python',
    'rust',
    'go',
    'haskell',
    'scheme',
    -- HPC
    'cuda',
    'fortran',
    -- shell scripts
    'fish',
    'bash',
    -- config files
    'yaml',
    'toml',
    -- vim/neovim
    'vim',
    'lua',
    'help',
    'query',
    -- doc files
    'markdown',
    'rst',
    'latex',
  },

  sync_install = false,

  -- use git to install parsers
  prefer_git = true,

  -- syntax highlighting module
  highlight = {
    -- bool, whether to enable treesitter plugin
    enable = true,

    -- list, ddisable treesitter for the listed languages
    -- NOTE: these are the **names of the parsers** and not the **filetype**
    disable = { },

    -- bool, whether to use treesitter and vim-regex-syntax simultaneously
    additional_vim_regex_highlighting = false,
  },

  -- indentation module
  indent = {
    enable = false,
  },

  -- see https://github.com/p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,

    -- list of languages you want to disable the plugin for
    disable = {},

    -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    extended_mode = true,

    -- Do not enable for files with more than n lines, int
    max_file_lines = nil,

    -- table of hex strings
    -- colors = {},
    -- table of colour name strings
    -- termcolors = {}
  }
}

ts.setup(ts_opts)

-- use tree-sitter based folding
vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]])
