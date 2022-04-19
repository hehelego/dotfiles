call plug#begin('~/.local/share/nvim/plugins')

" for LSP-client and CocList
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" for rust-lang enchancement
Plug 'rust-lang/rust.vim'
" for viewing symbol/tag tree
Plug 'liuchengxu/vista.vim'

" tree-sitter plugin for highlighting and text-object
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/playground'


" for devicons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
" colorscheme
Plug 'EdenEast/nightfox.nvim'

" for welcome menu
Plug 'mhinz/vim-startify'
" for status-line and tab-line
Plug 'nvim-lualine/lualine.nvim'
" for file tree
Plug 'kyazdani42/nvim-tree.lua'


" for FZF,ag,rg integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" for jumping between directories
Plug 'nanotee/zoxide.vim'

" for running shell command asynchronously
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" for git integration
Plug 'tpope/vim-fugitive'

" for viewing change history and back tracing
Plug 'mbbill/undotree'

" for quick commenting/uncommenting
Plug 'preservim/nerdcommenter'

" text alignment
Plug 'junegunn/vim-easy-align'

" for quick cursor navigating
Plug 'easymotion/vim-easymotion'

" for whichkey keybindings map
Plug 'folke/which-key.nvim'

" for markdown/latex previewing 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'xuhdev/vim-latex-live-preview'



" for risc-v assembly syntax support
Plug 'henry-hsieh/riscv-asm-vim'
call plug#end()
