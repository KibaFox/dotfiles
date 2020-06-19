" Leader mapping
" ==============

" Map <Leader> to space-bar
" Set this before everything else.
let mapleader = "\<Space>"

" Load Plugins
" ============

call plug#begin()

" Look and feel
" -------------
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'qpkorr/vim-bufkill'
Plug 'justincampbell/vim-eighties' " Automatically resizes your windows
Plug 'tpope/vim-eunuch' " Unix helpers
Plug 'tpope/vim-unimpaired' " Paired keybindings
Plug 'tpope/vim-repeat' " enable repeating supported plugin maps with '.'
Plug 'vim-scripts/scratch.vim' " Scratch buffer
Plug 'majutsushi/tagbar' " a class outline viewer

" Navigation
" ----------
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " fuzzy finder
Plug 'jremmen/vim-ripgrep'

" Coding
" ------
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'tag': '5.2', 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale', { 'tag': 'v2.7.0' }

" Writing
" -------
Plug 'reedes/vim-pencil'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'

" PlantUML
" --------
Plug 'weirongxu/plantuml-previewer.vim' " live preview
	Plug 'aklt/plantuml-syntax'     " syntax and :make
	Plug 'tyru/open-browser.vim'    " open browser

" Language & Syntax
" -----------------
Plug 'sheerun/vim-polyglot' " Provides basic support for a variety of languages
Plug 'fatih/vim-go', { 'tag': 'v1.23', 'do': ':GoUpdateBinaries' } " Golang

call plug#end()

" Plugin Configuration
" ====================

" Gruvbox colorscheme
" -------------------
if !empty(glob("~/.config/nvim/plugged/gruvbox"))
	let g:gruvbox_contrast_dark = 'hard'
	let g:gruvbox_italic = 1
	set background=dark
	colorscheme gruvbox
endif

" Airline
" -------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

" plasticboy/vim-markdown
" -----------------------
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_conceal = 2
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_disabled = 1

" Pencil
" ------
let g:pencil#textwidth = 80             " Set pencil's width
let g:pencil#wrapModeDefault = 'soft'   " Use soft wrap
let g:pencil#joinspaces = 1             " Use two spaces after a period

" w0rp/ale
" --------
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 750
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never' " save CPU and batery
let g:ale_linters_explicit = 1
let g:ale_linters = {'go': ['gopls', 'golangci-lint']}
let g:ale_fixers = {'go': ['goimports']}

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Deoplete.nvim
" -------------
let g:deoplete#enable_at_startup = 1

" Use ALE as completion sources all code.
let g:deoplete#sources = {'go': ['ale']}

" Vim-Go
" ------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = 'gopls'

" eighties.vim
" ------------
let g:eighties_extra_width = 2

" planuml-previewer.vim
" ---------------------
" MacOS get plantuml.jar path after brew install plantuml`
au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
	\  matchlist(system('grep plantuml.jar /usr/local/bin/plantuml'), '\v.* (\S+plantuml\.jar).*'),
	\  1,
	\  0
	\)

" Options
" =======

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

" Make it obvious where 80 characters is
set colorcolumn=81

" Line Numbers
" Relative in Normal, Absolute in Insert
" https://jeffkreeftmeijer.com/vim-number/
set numberwidth=5
set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Terminal
au TermOpen * setlocal nonumber norelativenumber

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Turn on 24-bit truecolor
set termguicolors

" Enable mouse
set mouse=a

" Fix w0rp/ale completion automatically inserting text
set completeopt=menu,menuone,preview,noselect,noinsert

if has("nvim-0.3.8") || has("patch-8.1.0360")
    set diffopt+=internal,algorithm:histogram
endif

" Mappings
" ========

" Spell check
" -----------
" Toggle spell check
nnoremap <Leader>s :set spell!<CR>

" Files
" -----
" fzf fuzzy file find
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles?<CR>

" open Ranger
nnoremap <leader>fr :Ranger<CR>

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

" Moving between errors (w0rp/ale)
" --------------------------------
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

" Go-Specific
" -----------
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

" fzf
" ---
" fzf mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Local Config
" ============
let $LOCALFILE=expand("~/.config/nvim/init_local.vim")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
