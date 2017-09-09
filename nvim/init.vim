" Map <Leader> to space-bar
" Set this before everything else.
let mapleader = "\<Space>"

" ==============================================================================
" Load Plugins
" ==============================================================================

call plug#begin()

" Look and feel
" -------------
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'qpkorr/vim-bufkill'
Plug 'myusuf3/numbers.vim' " better line numbers
Plug 'justincampbell/vim-eighties' " Automatically resizes your windows

" Navigation
" ----------
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " fuzzy finder

" Coding
" ------
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Writing
" ------
Plug 'reedes/vim-pencil'

" Language & Syntax
" -----------------
Plug 'sheerun/vim-polyglot' " Provides basic support for a variety of languages
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'fatih/vim-go' " Golang
    Plug 'zchee/deoplete-go', { 'do': 'make' } " completions for Go
    Plug 'garyburd/go-explorer' " better documentation viewer

call plug#end()

" ==============================================================================
" Plugin Configuration
" ==============================================================================

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
let g:airline_theme = 'gruvbox'

" Markdown
" --------

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

" Pencil
" ------
let g:pencil#textwidth = 80             " Set pencil's width
let g:pencil#wrapModeDefault = 'soft'   " Use soft wrap
let g:pencil#joinspaces = 1             " Use two spaces after a period

" Deoplete.nvim
" -------------
let g:deoplete#enable_at_startup = 1

" Deoplete-go
" -----------
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'

" Vim-Go
" ------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" eighties.vim
" ------------
let g:eighties_extra_width = 4

" ==============================================================================
" Editing Options
" ==============================================================================

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

" Make it obvious where 80 characters is
set colorcolumn=81

" Numbers
set number
set numberwidth=5

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" ==============================================================================
" Mappings
" ==============================================================================

" Toggle spell check
nnoremap <Leader>s :set spell!<CR>

" fzf fuzzy file find
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles?<CR>

" Buffer navigation and management
" fzf fuzzy buffer navigation
nnoremap <leader>bb :Buffers<CR>
" Delete a buffer without closing the split using vim-buffkill
nnoremap <C-x> :BD<CR>
nnoremap <leader>bx :BD<CR>

" Auto formatting for manually converting to hard wrap
" Format paragraph
nnoremap <silent> <leader>q gqap
" Format selection (visual mode)
xnoremap <silent> <leader>q gq

" Go-Specific
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>l :GoLint<CR>
au FileType go nmap <leader>q :GoImport<space>
au FileType go nmap <Leader>g <Plug>(go-implements)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <Leader>s <Plug>(go-install)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>v <Plug>(go-vet)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>gs <Plug>(go-doc-split)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" fzf mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
