" Map <Leader> to space-bar
let mapleader = "\<Space>"

" Use filetype plugins
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Turn on persistent undo
set undofile

" Show whitespace
set list

" Mappings
" --------

" Toggle spell check
nnoremap <Leader>s :set spell!<CR>

" Buffer navigation
map <C-n> :bnext<CR>
map <C-p> :bpref<CR>
