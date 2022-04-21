-- see https://github.com/folke/which-key.nvim

local wk = require('which-key')

local whichkey_config = {}
wk.setup(whichkey_config)

local fzf_keymap = {
  name = 'fzf',
  -- find files
  f = 'files',
  g = 'git-files',
  h = 'history',
  r = 'ripgrep',
  a = 'silver-search',
  -- find in buffers and windows
  b = 'buffers',
  w = 'windows',
}
local fzf_ex_keymap = {
  name = 'fzf-ex',

  c = 'commands',
  h = 'helps',
  k = 'key-bindings',
  m = 'marks',
  r = 'registers',
  t = 'asynctasks',
}
local buffer_keymap = {
  name = 'buffer',
  b = 'find-buffer',
  f = 'search-contents',
  s = 'source-vimscript',
  t = 'select-filetype',
  -- buffer switching
  n = 'next',
  p = 'prev',
  c = 'delete',
  d = 'delete',
  r = 'reload',
}
local editorui_keymap = {
  name = 'editor-ui',

  m = 'mouse',
  l = 'hl-line',
  c = 'hl-column',
  a = 'ln-absolute',
  r = 'ln-relative',
  t = 'transparent-bg',
  s = 'colors',
  p = 'pair-color',
}
local comment_keymap = {
  name = 'comment',

  c = 'on',
  i = 'invert',
  t = 'toggle',
  u = 'off',
  y = 'yank',
}
local quickfix_keymap = {
  name = 'quickfix',

  c = 'close',
  n = 'next',
  o = 'open',
  p = 'prev',
}
local git_keymap = {
  name = 'git',
  -- TODO: more git integration
  g = 'repo-summary',
  b = 'blame %',
  l = 'log %',
  L = 'log',
  d = 'diff %',
}
local aerial_keymap = {
  name = 'aerial',

  f = 'finder',
  s = 'toggle',
}
local undotree_keymap = {
  name = 'undo-tree',

  u = 'toggle',
  o = 'focus',
  c = 'close',
}
local asynctasks_keymap = {
  a = 'list',
  s = 'stop',
}
asynctasks_keymap['.'] = 'run-last'
local zoxide_keymap = {
  z = 'home',
  i = 'find-jump',
}

--
-- SECTION: leader keymap
--

local leader_keymap = {
  name = '<leader>',

  a = asynctasks_keymap,
  b = buffer_keymap,
  c = comment_keymap,
  e = editorui_keymap,
  f = fzf_keymap,
  F = fzf_ex_keymap,
  g = git_keymap,
  q = quickfix_keymap,
  s = aerial_keymap,
  t = 'file-explorer',
  u = undotree_keymap,
  w = 'word-lookup',
  z = zoxide_keymap,
}
leader_keymap['<space>'] = {
  name = 'MORE',
  p = {
    name = 'plugins',

    c     = { '<CMD>PlugClean<CR>', 'vimplug-clean' },
    d     = { '<CMD>PlugDiff<CR>', 'vimplug-diff' },
    i     = { '<CMD>PlugInstall<CR>', 'vimplug-install' },
    s     = { '<CMD>PlugStatus<CR>', 'vimplug-status' },
    u     = { '<CMD>PlugUpdate<CR>', 'vimplug-update' },
    U     = { '<CMD>PlugUpgrade<CR>', 'vimplug-upgrade' },
    [';'] = { '<CMD>CocUpdate<CR>', 'coc-update' },
  },
  v = {
    name = 'document-preview',

    m = {
      name = 'markdown',
      m = { '<CMD>MarkdownPreview<CR>', 'start' },
      s = { '<CMD>MarkdownPreviewStop<CR>', 'shutdown' },
      t = { '<CMD>MarkdownPreviewStop<CR>', 'toggle' },
    },
    t = {
      name = 'LaTeX',
      t = { '<CMD>LLPStartPreview<CR>', 'start' },
    },
  },
}
wk.register(leader_keymap, { prefix = '<leader>' })


--
-- SECTION: coc LSP keymap
--


local coc_keymap = {
  name = 'coc',

  a = 'apply-codeaction',
  f = 'format',
  q = 'quickfix-current',
  r = 'rename',
  l = {
    name = 'coc-list',

    c = 'commands',
    d = 'diagnostics',
    l = 'lists',
    t = 'async-tasks',
  },
}
wk.register(coc_keymap, { prefix = ';' })

--
-- SECTION: hop.nvim keymap
--

local hop_keymap = {
  name = 'motion',

  f = 'char1-f', t = 'char1-t',
  g = 'char2-f', h = 'char2-t',
  w = 'word-beg', e = 'word-end',
  j = 'line-beg', k = 'line-end',
}
hop_keymap['/'] = 'pattern'
hop_keymap[','] = 'anywhere'
wk.register(hop_keymap, { prefix = ',' })
