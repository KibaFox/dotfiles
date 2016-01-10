" Map <Leader> to space-bar
" Set this before everything else.
let mapleader = "\<Space>"

" Load Plugins
" ============

call plug#begin()

" Look and feel
" ----------
Plug 'w0ng/vim-hybrid'
Plug 'bling/vim-airline'

" Coding
" ------
Plug 'editorconfig/editorconfig-vim'

" Writing
" ------
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

" Language & Syntax
" -----------------
Plug 'tpope/vim-git'

call plug#end()

" Plugin Configuration
" ====================

" Hybrid Colorscheme
" ------------------
if !empty(glob("~/.config/nvim/plugged/vim-hybrid"))
    set background=dark
    let g:hybrid_custom_term_colors = 1
    colorscheme hybrid
endif

" Airline
" -------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'hybridline'

" Enable tabline
let g:airline#extensions#tabline#enabled = 1

" Goyo
" ----

let g:goyo_width = 80

" Goyo Mappings
" -------------

" Toggle distraction-free mode
nnoremap <leader>w :Goyo<CR>

" Pencil
" ------
let g:pencil#textwidth = 80             " Set pencil's width
let g:pencil#wrapModeDefault = 'soft'   " Use soft wrap
let g:pencil#joinspaces = 1             " Use two spaces after a period
if !empty(glob("~/.config/nvim/plugged/goyo.vim"))
    augroup pencil
        autocmd!
        autocmd FileType markdown call pencil#init()
        autocmd FileType text     call pencil#init()
    augroup END
endif

" Syntax Highlighting and Indentation
" ===================================

" Use filetype detection
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Italic comments
highlight Comment cterm=italic

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
