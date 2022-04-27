-- See <https://neovim.io/doc/user/options.html>
local opts = {
	-- MISC
	guifont = "monospace:h12", -- font for gui-version of neovim
	termguicolors = true, -- enable true-color support
	mouse = "a", -- eanble mouse on every editing mode
	undofile = true, -- enable persistent undo history
	clipboard = "unnamedplus", -- use system clipboard

	-- buf write
	backup = false, -- do not create a backup file when writing buffer to disk
	writebackup = true, -- backup the buffer when before writing it to disk
	encoding = "utf-8", -- neovim internal RPC encoding
	fileencoding = "utf-8", -- encoding to use when writing buffer to disk

	-- pattern search
	hlsearch = true, -- highlight the matches, use normal-mode <C-l> to clear
	ignorecase = true, -- ignore case for letters by default
	smartcase = true, -- disable ignore case when the pattern contains upper-case letters
	incsearch = true, -- show matches as we type the pattern

	-- editor ui
	showmode = false, -- do not display the current editing mode on last line
	wrap = false, -- disable wrapping display for long line
	number = true, -- display line number
	relativenumber = true, -- display relative line number
	showtabline = 2, -- always show the tabline
	conceallevel = 0, -- disable text concealing
	list = true, -- display white-space characters
	laststatus = 3, -- global status line

	-- inserting text
	autoindent = true, -- enable auto indenting
	smartindent = true, -- C-alike indenting style by default
	expandtab = false, -- do not expand tab characters
	tabstop = 4, -- display tab character as 4 spaces
	shiftwidth = 4, -- add/reduce 4 spaces in every shift operation
	completeopt = "menu,menuone,noselect",

	-- delays
	timeoutlen = 300, -- wait 100ms before a key-stroke sequence to complete
	updatetime = 300, -- time to wait before auto-complete get updated
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

vim.opt.shortmess:append("c")

-- display ' ' as '·'
vim.opt.listchars:append("space:·")
-- display '\n' as '↴'
vim.opt.listchars:append("eol:↴")