set nocompatible
let mapleader = "\<Space>" " Map <Leader> to space-bar

" Plugins
" =======

call plug#begin()

" Look and feel
Plug 'morhetz/gruvbox'               " colorscheme
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'qpkorr/vim-bufkill'
Plug 'justincampbell/vim-eighties'   " automatically resize windows
Plug 'tpope/vim-eunuch'              " unix helpers
Plug 'tpope/vim-unimpaired'          " paired keybindings
Plug 'tpope/vim-repeat'              " enable repeating supported plugin maps with '.'
Plug 'vim-scripts/scratch.vim'       " scratch buffer

" Navigation
Plug 'justinmk/vim-dirvish'
Plug 'wincent/ferret'                " search w/ ripgrep (rg) using :Ack
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'              " fuzzy finder

" Coding
Plug 'editorconfig/editorconfig-vim' " per-project editor configuration
Plug 'tpope/vim-fugitive'            " git commands

" Writing
Plug 'reedes/vim-pencil'             " handle hard and soft line wrap
Plug 'junegunn/goyo.vim'             " distraction-free writing

" Language & Syntax
Plug 'sheerun/vim-polyglot'          " syntax highlighting for many languages
	Plug 'godlygeek/tabular'     " plasticboy/vim-markdown :TableFormat
Plug 'https://tildegit.org/sloum/gemini-vim-syntax' " gemini syntax highlights
Plug 'fatih/vim-go', { 'tag': 'v1.24', 'do': ':GoUpdateBinaries' } " Golang
Plug 'dense-analysis/ale', { 'tag': 'v3.1.0' } " Asynchronous Lint Engine

call plug#end()

" Plugin Configuration
" ====================

" Gruvbox colorscheme
if !empty(glob("~/.vim/plugged/gruvbox"))
	let g:gruvbox_contrast_dark = 'hard'
	let g:gruvbox_italic = 1
	set background=dark
	colorscheme gruvbox
endif

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

" plasticboy/vim-markdown
let g:vim_markdown_frontmatter = 1      " frontmatter hightlights
let g:vim_markdown_toml_frontmatter = 1 " TOML frontmatter highlights
let g:vim_markdown_conceal = 0          " Don't conceal syntax
let g:vim_markdown_folding_disabled = 1 " Diable folding at headers

" Pencil
let g:pencil#textwidth = 80             " Set pencil's width
let g:pencil#wrapModeDefault = 'soft'   " Use soft wrap by default
let g:pencil#joinspaces = 1             " Use two spaces after a period

" Vim-Terraform - included w/ vim-polyglot
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" eighties.vim
let g:eighties_extra_width = 2

" goyo.vim
let g:goyo_height = '100%'

" Vim-Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1

" Ale
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never' " save CPU and batery
let g:ale_linters_explicit = 1
let g:ale_linters = {'go': ['gopls', 'golangci-lint']}
let g:ale_fixers = {'go': ['goimports']}
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Options
" =======
set undofile            " turn on persistent undo
set list                " show whitespace
set nowrap              " default to nowrap (helps when coding side-by-side)
let &showbreak = '+   ' " soft indent for soft wrap lines
set ruler               " show position in file
set ignorecase          " case-insensitive search
set smartcase           " smart case-insensitive search
set hidden              " allow buffers with unsaved changes to be hidden
set colorcolumn=81      " make it obvious where 80 characters is
set numberwidth=5       " reserve column width for line numbers
set number norelativenumber " show fixed line numbers
set complete+=kspell    " autocomplete with dictionary words when spell check is on
set termguicolors       " turn on 24-bit truecolor
set mouse=a             " enable mouse

if has("nvim-0.3.8") || has("patch-8.1.0360") " histogram diffs are easier to read
	" for some reason this doesn't work for the VIM that comes with MacOS
	silent! set diffopt+=filler,internal,algorithm:histogram,indent-heuristic
endif

" Mappings
" ========

" Spell check
" -----------

" Toggle spell check
nnoremap <Leader>s :set spell!<CR>

" Toggle Numbers and Gutters
" -------------------
nnoremap <Leader>n :set number!<CR>:ALEToggle<CR>:GitGutterToggle<CR>

" Files
" -----
" fzf fuzzy file find
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles?<CR>

" open Dirvish
nnoremap <leader>fd :Dirvish<CR>

" Buffers
" -------
" Buffer navigation and management
" fzf fuzzy buffer navigation
nnoremap <leader>bb :Buffers<CR>
" Delete a buffer without closing the split using vim-buffkill
nnoremap <C-x> :BD<CR>
nnoremap <leader>bx :BD<CR>

" Formatting
" ----------
" Auto formatting for manually converting to hard wrap
" Format paragraph
nnoremap <silent> <leader>q gqap
" Format selection (visual mode)
xnoremap <silent> <leader>q gq

" json-specific
" ------------
" prettyify json
au FileType json nmap <Leader>p :%!python -m json.tool<CR>

" Goyo
" ----
" Toggle distraction-free mode
nnoremap <leader>w :Goyo<CR>

" Filetype Configuration
" ======================
augroup gitcommit
	au FileType gitcommit setlocal textwidth=72
	au FileType gitcommit setlocal colorcolumn=+1
	au FileType gitcommit setlocal spell
augroup END

augroup gitconfig
	au FileType gitconfig setlocal noexpandtab
	au FileType gitconfig setlocal tabstop=4
augroup END

augroup gmi
	au BufRead,BufNewFile *.gmi.txt set filetype=gmi
	au FileType gmi call pencil#init({'wrap': 'soft'})
	au FileType gmi setlocal spell
augroup END

augroup markdown
	au FileType markdown call pencil#init({'wrap': 'soft'})
	au FileType markdown setlocal spell
augroup END

augroup text
	au FileType text call pencil#init({'wrap': 'soft'})
	au FileType text setlocal spell
augroup END

" Local Config
" ============
let $LOCALFILE=expand("~/.vim/init_local.vim")
if filereadable($LOCALFILE)
	source $LOCALFILE
endif
