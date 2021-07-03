set nocompatible
let mapleader = "\<Space>" " Map <Leader> to space-bar

" Plugins
" =======

call plug#begin()

" Look and feel
Plug 'morhetz/gruvbox'               " colorscheme
Plug 'itchyny/lightline.vim'
	Plug 'shinchu/lightline-gruvbox.vim' " colorscheme for lightline
	Plug 'maximbaz/lightline-ale'        " integration with ale
Plug 'airblade/vim-gitgutter'
Plug 'qpkorr/vim-bufkill'
Plug 'justincampbell/vim-eighties'   " automatically resize windows
Plug 'tpope/vim-eunuch'              " unix helpers
Plug 'tpope/vim-unimpaired'          " paired keybindings
Plug 'tpope/vim-repeat'              " enable repeating supported plugin maps with '.'
Plug 'tpope/vim-vinegar'             " enhance netrw
Plug 'vim-scripts/scratch.vim'       " scratch buffer

" Navigation
Plug 'christoomey/vim-tmux-navigator'

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

" Neovim 0.5.0+ required
if has("nvim-0.5.0")
	Plug 'neovim/nvim-lspconfig' " Replaces ALE and vim-go
	Plug 'nvim-telescope/telescope.nvim' " Replaces CtrlP/fzf
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'hrsh7th/nvim-compe' " Code completion suggestions
else
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'fatih/vim-go', { 'tag': 'v1.25', 'do': ':GoUpdateBinaries' } " Golang
	Plug 'dense-analysis/ale', { 'tag': 'v3.1.0' } " Asynchronous Lint Engine
endif

call plug#end()

" Plugin Configuration
" ====================

" Gruvbox colorscheme
if has('nvim') && !empty(glob("~/.config/nvim/plugged/gruvbox")) || !empty(glob("~/.vim/plugged/gruvbox"))
	let g:gruvbox_contrast_dark = 'hard'
	let g:gruvbox_italic = 0
	"let g:gruvbox_termcolors = 16 " use terminal palette
	set background=dark
	colorscheme gruvbox
endif

" lineline
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.component_expand = {
	\ 'linter_checking': 'lightline#ale#checking',
	\ 'linter_infos': 'lightline#ale#infos',
	\ 'linter_warnings': 'lightline#ale#warnings',
	\ 'linter_errors': 'lightline#ale#errors',
	\ 'linter_ok': 'lightline#ale#ok',
	\ 'tabs': 'lightline#tabs',
	\ }
let g:lightline.component_type = {
	\ 'linter_checking': 'right',
	\ 'linter_infos': 'right',
	\ 'linter_warnings': 'warning',
	\ 'linter_errors': 'error',
	\ 'linter_ok': 'right',
	\ 'tabs': 'tabsel',
	\ 'close': 'raw',
	\ }
let g:lightline.active = {
	\ 'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
	\ 'right': [
		\ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
		\ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'],
	\ ]
\ }
let g:lightline#ale#indicator_infos = 'ℹ '
let g:lightline#ale#indicator_warnings = '⤫ '
let g:lightline#ale#indicator_errors = '⚠ '
let g:lightline#ale#indicator_ok = '✔︎'

" ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<Leader>ff'
if executable('rg')
	set grepprg=rg\ --color=never
	let g:ctrlp_user_command = 'rg %s --color never --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
	let g:ctrlp_use_caching = 0
endif

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
let g:ale_linters = {
	\ 'go': ['gopls', 'golangci-lint'],
	\ 'markdown': ['markdownlint'],
\ }
let g:ale_fixers = {
	\ '*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 'go': ['goimports'],
\ }
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

if has("nvim-0.5.0")
lua << EOF
require'lspconfig'.gopls.setup{}
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true,
	}
}
require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
}
EOF
endif

" Options
" =======
set undofile            " turn on persistent undo
set list                " show whitespace
set nowrap              " default to nowrap (helps when coding side-by-side)
let &showbreak = '+   ' " soft indent for soft wrap lines
set ignorecase          " case-insensitive search
set smartcase           " smart case-insensitive search
set hidden              " allow buffers with unsaved changes to be hidden
set colorcolumn=81      " make it obvious where 80 characters is
set numberwidth=5       " reserve column width for line numbers
set number norelativenumber " show fixed line numbers
set complete+=kspell    " autocomplete with dictionary words when spell check is on
set notermguicolors     " turn off 24-bit truecolor
set mouse=a             " enable mouse
set completeopt=menuone,noselect " required for hrsh7th/nvim-compe

" Use NeoVIM Defaults
" https://neovim.io/doc/user/vim_diff.html
if !has('nvim')
	set autoindent          " copy indent from current line when starting a new line
	set autoread            " auto read when a file change is detected outside vim
	set backspace=indent,eol,start " allow backspace in these scenarios
	set belloff=all         " turn off bell for all events
	set complete-=i         " do not scan current and included files for keyword completion
	set cscopeverbose       " give messages when adding a cscope database
	set display=lastline    " display as much as possible & use '@@@' at end if more
	set encoding=utf-8      " uft-8 text encoding
	set fillchars=vert:\|,fold:· " chars to fill statuslines and vertical separators
	set formatoptions=tcqj  " t=textwidth; c=comments; q=`gq`; j=join comments
	set history=10000       " history of ':' commands.
	set hlsearch            " highlight all search matches
	set incsearch           " show first match of search while typing
	set nolangremap         " no keyboard language remapping
	set laststatus=2        " always show the status line
	set listchars=tab:>\ ,trail:-,nbsp:+
	set ruler               " show position in file
	set sessionoptions+=unix,slash " unix=with new line at EOF; slash=forward slash
	set sessionoptions-=options " don't save options with :mksession
	set shortmess+=F        " don't give file info when editing a file, like :silent
	set shortmess-=S        " show search count when searching
	set showcmd             " show (partial) command in the last line of the screen
	set sidescroll=1        " minimal # of columns to scroll horizontally
	set smarttab            " smart tab replacement when indenting with spaces
	set tabpagemax=50       " max # of pages to be opened by the -p flag or `:tab all`
	set tags=./tags;,tags   " filenames for the tag command
	set ttimeoutlen=50      " time(ms) to wait for key code or mapped sequence
	set ttyfast             " assume a fast terminal connection
	set viewoptions=unix,slash " unix=with new line at EOF; slash=forward slash
	set viminfo+=!          " add saving global variables that start with uppercase
	set wildmenu            " tab completion for commands
	packadd! matchit        " enable match enhancements when using '%'

	" Directories for backup, swap, and undo.  Create them if they do not exist.
	let $BACKUP_DIR=expand("~/.vim/backup")
	let $SWAP_DIR=expand("~/.vim/swap")
	let $UNDO_DIR=expand("~/.vim/undo")
	if !isdirectory($BACKUP_DIR)
		call mkdir($BACKUP_DIR, "p")
	endif
	if !isdirectory($SWAP_DIR)
		call mkdir($SWAP_DIR, "p")
	endif
	if !isdirectory($UNDO_DIR)
		call mkdir($UNDO_DIR, "p")
	endif
	set backupdir=$BACKUP_DIR
	set directory=$SWAP_DIR//
	set undodir=$UNDO_DIR
endif

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

" Buffers
" -------
if has("nvim-0.5.0")
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
else
	" Buffer navigation and management
	nnoremap <leader>bb :CtrlPBuffer<CR>
endif
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

augroup packer
	au BufWritePost *.pkr.hcl silent! execute "!packer fmt % >/dev/null 2>&1" | redraw!
augroup END

" Local Config
" ============
if has('nvim')
	let $LOCALFILE=expand("~/.config/nvim/local.vim")
else
	let $LOCALFILE=expand("~/.vim/local.vim")
endif
if filereadable($LOCALFILE)
	source $LOCALFILE
endif
