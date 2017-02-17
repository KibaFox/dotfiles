" Map <Leader> to space-bar
" Set this before everything else.
let mapleader = "\<Space>"

" Use a POSIX shell for compatibility
if $SHELL =~ 'fish'
  let &shell='/usr/bin/env bash'
endif

" Load Plugins
" ============

call plug#begin()

" Look and feel
" ----------
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'justinmk/vim-dirvish'
Plug 'qpkorr/vim-bufkill'
Plug 'godlygeek/tabular'
Plug 'rbgrouleff/bclose.vim' " Dependency for ranger.vim
Plug 'francoiscabrol/ranger.vim'
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'myusuf3/numbers.vim' " better line numbers
Plug 'justincampbell/vim-eighties' " Automatically resizes your windows
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " fuzzy finder

" Coding
" ------
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'neomake/neomake'

" Writing
" ------
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

" Language & Syntax
" -----------------
Plug 'tpope/vim-git'
Plug 'LnL7/vim-nix'
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'robbles/logstash.vim'

" Elixir
" ------
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Golang
" ------
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'garyburd/go-explorer'

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
let g:airline_theme = 'gruvbox'

" Goyo
" ----

let g:goyo_width = 82 " Give some room to avoid side-scrolling on hard wrap

" Markdown
" --------

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

" Goyo Mappings
" -------------

" Toggle distraction-free mode
nnoremap <leader>w :Goyo<CR>

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
let g:deoplete#sources#go#json_directory = 	'~/.cache/deoplete/go/$GOOS_$GOARCH'

" Vim-Go
" ------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" Fix syntastic lagging while saving and opening files with vim-go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Rust.vim
" --------
let g:rustfmt_autosave = 1

" eighties.vim
let g:eighties_extra_width = 4

" Tmux Navigator
" --------------
" Hacky solution to C-h sending backspace, which causes C-h to not work when
" switching panes to the left.
" https://github.com/christoomey/vim-tmux-navigator#it-doesnt-work-in-neovim-specifically-c-h
"nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

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

" Make it obvious where 80 characters is
set colorcolumn=81

" Numbers
set number
set numberwidth=5

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Mappings
" ========

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
