" Map <Leader> to space-bar
" Set this before everything else.
let mapleader = "\<Space>"

" Load Plugins
" ============

call plug#begin()

" Look and feel
" ----------
Plug 'morhetz/gruvbox'
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
Plug 'LnL7/vim-nix'

call plug#end()

" Plugin Configuration
" ====================

" Hybrid Colorscheme
" ------------------
if !empty(glob("~/.config/nvim/plugged/gruvbox"))
    let g:gruvbox_italic = 1
    set background=dark
    colorscheme gruvbox
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

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Location of my spellfile
set spellfile=$HOME/.dotfiles_local/nvim/spell/en.utf-8.add

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

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
