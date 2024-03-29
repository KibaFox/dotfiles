function vipk --description 'Update NeoVIM packages'
	set -l start 'config/nvim/pack/mypkg/start'
	set -l opt 'config/nvim/pack/mypkg/opt'

	# clean the pack directory (it should be stored in git)
	rm -rf 'config/nvim/pack'

	function _dl --description "Download and expand a .tar.gz"
		set -l dest "$argv[1]" # destination directory
		set -l url "$argv[2]"  # URL of .tar.gz to download
		set -l tmp (mktemp -t (basename "$dest")) # create temporary path

		echo "$dest"
		curl -sSfL -o "$tmp" "$url" # download to temporary path
		rm -rf "$dest"              # remove destination directory
		mkdir -p "$dest"            # create destination directory
		tar -xzf "$tmp" -C "$dest" --strip-components=1 # extract to dest
		rm "$tmp"                   # cleanup temporary path
	end

	function _dlf --description "Download a file to a destination"
		set -l dest "$argv[1]" # destination file path
		set -l url "$argv[2]"  # URL of the file to download

		echo "$dest"
		mkdir -p (dirname "$dest")   # make the destination directory
		curl -sSfL -o "$dest" "$url" # download file to destination path
	end

	# Color scheme
	_dl "$opt/gruvbox" \
	   'https://github.com/morhetz/gruvbox/archive/refs/heads/master.tar.gz'

	# Minimal status line
	_dl "$start/lightline.vim" \
	   'https://github.com/itchyny/lightline.vim/archive/refs/heads/master.tar.gz'

	# Minimal status line color scheme
	_dl "$start/lightline-gruvbox.vim" \
	   'https://github.com/shinchu/lightline-gruvbox.vim/archive/refs/heads/master.tar.gz'

	# Show current git changes in gutter
	_dl "$start/vim-gitgutter" \
	   'https://github.com/airblade/vim-gitgutter/archive/refs/heads/master.tar.gz'

	# Kill buffers without closting the window or split
	_dl "$start/vim-bufkill" \
	   'https://github.com/qpkorr/vim-bufkill/archive/refs/heads/master.tar.gz'

	# Automatically resize window width when switching
	_dl "$start/vim-eighties" \
	   'https://github.com/justincampbell/vim-eighties/archive/refs/heads/master.tar.gz'

	# Functions for commonly used UNIX shell commands
	_dl "$start/vim-eunich" \
	   'https://github.com/tpope/vim-eunuch/archive/refs/heads/master.tar.gz'

	# Pairs of handy bracket mappings
	_dl "$start/vim-unimpaired" \
	   'https://github.com/tpope/vim-unimpaired/archive/refs/heads/master.tar.gz'

	# Enable repeating supported plugin maps with `.`
	_dl "$start/vim-repeat" \
	   'https://github.com/tpope/vim-repeat/archive/refs/heads/master.tar.gz'

	# Enhance netrw
	_dl "$start/vim-vinegar" \
	   'https://github.com/tpope/vim-vinegar/archive/refs/heads/master.tar.gz'

	# Git wrappers
	_dl "$start/vim-fugitive" \
	   'https://github.com/tpope/vim-fugitive/archive/refs/heads/master.tar.gz'

	# Scratch buffer
	_dl "$start/scratch.vim" \
	   'https://github.com/vim-scripts/scratch.vim/archive/refs/heads/master.tar.gz'

	# Per-project editor configuration
	_dl "$start/editorconfig-vim" \
	   'https://github.com/editorconfig/editorconfig-vim/archive/refs/heads/master.tar.gz'

	# Handle hard and soft line wrap
	_dl "$start/vim-pencil" \
	   'https://github.com/reedes/vim-pencil/archive/refs/heads/master.tar.gz'

	# Distraction-free writing
	_dl "$start/goyo.vim" \
	   'https://github.com/junegunn/goyo.vim/archive/refs/heads/master.tar.gz'

	# Syntax highlighting for many languages
	_dl "$start/vim-polyglot" \
	   'https://github.com/sheerun/vim-polyglot/archive/refs/heads/master.tar.gz'

	# Support plasticboy/vim-markdown :TableFormat (from vim-polyglot)
	_dl "$start/tabular" \
	   'https://github.com/godlygeek/tabular/archive/refs/heads/master.tar.gz'

	# Gemini syntax highlighting
	_dl "$start/gemini-vim-syntax" \
	   'https://tildegit.org/sloum/gemini-vim-syntax/archive/master.tar.gz'

	# fzf integration for fuzzy file search
	_dl "$start/fzf.vim" \
	   'https://github.com/junegunn/fzf.vim/archive/refs/heads/master.tar.gz'

	# fzf requires this from the main repository to work
	_dlf "$start/fzf/LICENSE" \
	   'https://raw.githubusercontent.com/junegunn/fzf/master/LICENSE'
	_dlf "$start/fzf/doc/fzf.txt" \
	   'https://raw.githubusercontent.com/junegunn/fzf/master/doc/fzf.txt'
	_dlf "$start/fzf/plugin/fzf.vim" \
	   'https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim'

end
