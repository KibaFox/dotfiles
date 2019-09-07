" Minimal Vim config

filetype plugin indent on
syntax enable

" Options
" -------

set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i
set cscopeverbose
set display=lastline
set encoding=utf-8
set fillchars=vert:\|,fold:·
set formatoptions=tcqj
set history=10000
set hlsearch
set incsearch
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
set nocompatible
set ruler
set sessionoptions-=options
set showcmd
set sidescroll=1
set smarttab
set tabpagemax=50
set tags=./tags;,tags
set ttyfast
set viminfo+=!
set wildmenu

" Turn on persistent undo
set undofile

" Show whitespace
set list

" Soft indent for soft wrap lines
let &showbreak = '+   '

" Show position in file
set ruler

" Smart case-insensitive search
set ignorecase
set smartcase

" Allow buffers with unsaved changes to be hidden
set hidden

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Mappings
" --------

" Map <Leader> to space-bar
let mapleader = "\<Space>"

" Toggle spell check
nnoremap <Leader>s :set spell!<CR>

" Delete buffer
nnoremap <C-x> :bdelete<CR>
