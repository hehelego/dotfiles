call plug#begin('~/.local/share/nvim/plugins')

""""""""""""""""""""""""""""""""""""""
" SECTION: UI
""""""""""""""""""""""""""""""""""""""

" for devicons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
" colorscheme
Plug 'EdenEast/nightfox.nvim'
" for welcome menu
Plug 'mhinz/vim-startify'
" for status-line and tab-line
Plug 'nvim-lualine/lualine.nvim'



""""""""""""""""""""""""""""""""""""""
" SECTION: tools
""""""""""""""""""""""""""""""""""""""

" for file tree
Plug 'kyazdani42/nvim-tree.lua'

" for viewing change history and back tracing
Plug 'mbbill/undotree'

" text alignment
Plug 'junegunn/vim-easy-align'

" for enhanced vim cursor motion
Plug 'phaazon/hop.nvim'

" for whichkey keybindings map
Plug 'folke/which-key.nvim'

" for runing command and/or spawning task
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'


""""""""""""""""""""""""""""""""""""""
" SECTION: integration
""""""""""""""""""""""""""""""""""""""

" for FZF,ag,rg integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" for jumping between directories
Plug 'nanotee/zoxide.vim'

" for git integration
Plug 'tpope/vim-fugitive'



""""""""""""""""""""""""""""""""""""""
" SECTION: lsp/dap/tree-sitter/semantics
""""""""""""""""""""""""""""""""""""""

" for quick commenting/uncommenting
Plug 'preservim/nerdcommenter'

" tree-sitter plugin for highlighting and text-object
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/playground'

" for LSP-client and CocList
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" for skiming through code structure and symbol tree
Plug 'stevearc/aerial.nvim'



""""""""""""""""""""""""""""""""""""""
" SECTION: language speical support
""""""""""""""""""""""""""""""""""""""

" for markdown/latex previewing 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'xuhdev/vim-latex-live-preview', { 'for': ['tex', 'vim-plug'] }

" for rust-lang enchancement
Plug 'rust-lang/rust.vim'

" for risc-v assembly syntax support
Plug 'henry-hsieh/riscv-asm-vim'


call plug#end()
