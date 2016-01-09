" Map <Leader> to space-bar
" Set this before everything else.
let mapleader = "\<Space>"

" Load Plugins
" ============

call plug#begin()

Plug 'bling/vim-airline'
Plug 'w0ng/vim-hybrid'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-git'

call plug#end()

" Plugin Configuration
" ====================

" Airline
" -------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'hybridline'

" Enable tabline
let g:airline#extensions#tabline#enabled = 1

" Hybrid Colorscheme
" ------------------

if !empty(glob("~/.config/nvim/plugged/vim-hybrid"))
    set background=dark
    let g:hybrid_custom_term_colors = 1
    colorscheme hybrid
endif

" Syntax Highlighting and Indentation
" ===================================

" Use filetype detection
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Editing Options
" ===============

" Turn on persistent undo
set undofile

" Show whitespace
set list

" Show position in file
set ruler

" Default to using 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Smart case-insensitive search
set ignorecase
set smartcase

" Allow buffers with unsaved changes to be hidden
set hidden

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Mappings
" ========

" Toggle spell check
nnoremap <Leader>s :set spell!<CR>

" Buffer navigation
map <C-n> :bnext<CR>
map <C-p> :bprev<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
