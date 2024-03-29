# Prompt settings
# ===============
# fish_git_prompt
# https://fishshell.com/docs/current/cmds/fish_git_prompt.html
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showstashstate

# fish_git_prompt colors
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_color_branch blue --bold
set __fish_git_prompt_color_cleanstate green --bold
set __fish_git_prompt_color_merging red
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_upstream yellow

# Environment Variables
# =====================
# EDITOR is vim, or vi; whichever is installed.
if command -q nvim
	set -x EDITOR nvim
else if command -q vim
	set -x EDITOR vim
else if command -q vi
	set -x EDITOR vi
end
set -x PAGER less
set -x GOPATH "$HOME/go"
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/rgrc"
set -x BAT_CONFIG_PATH "$HOME/.config/bat/batrc"
set -x LC_ALL "en_US.UTF-8"

# FZF_DEFAULT_COMMAND prefer ripgrep, use silver searcher as a fallback.
if command -q rg
	set -x FZF_DEFAULT_COMMAND 'rg --color never --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
else if command -q ag
	set -x FZF_DEFAULT_COMMAND 'ag --nocolor -l --hidden --follow --ignore-dir .git --ignore-dir vendor'
end

# mosh-server sessions timeout after one week
set -x MOSH_SERVER_NETWORK_TMOUT '604800'
# mosh-server inactive sessions can be killed with: pkill -SIGUSR1 mosh-server
set -x MOSH_SERVER_SIGNAL_TMOUT '28800'

# Set PATH so it includes user's private bin directories (if they exist)
set -la user_paths "$HOME/.local/bin"
set -la user_paths "$HOME/.config/emacs/bin"
set -la user_paths "$GOPATH/bin"
set -la user_paths "/usr/local/go/bin"
set -la user_paths "/usr/local/opt/mozjpeg/bin" # brew install mozjpeg
set -la user_paths "/usr/local/opt/mysql-client/bin" # brew install mysql-client
for dir in $user_paths
	if test -d "$dir"
		set -ga fish_user_paths "$dir"
	end
end

#set -x GPG_TTY (tty)
#set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
#if test ! -e $SSH_AUTH_SOCK
#	# If the socket doesn't exist...
#	# Start the gpg-agent
#	gpgconf --launch gpg-agent
#	set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
#end

set -l pinentry_mac \
	'/usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac'
if test -e $pinentry_mac
	alias pinentry "$pinentry_mac"
end

# SSH agent
# =========
# Source: https://github.com/danhper/fish-ssh-agent
if test -z "$SSH_ENV"
	set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
	__ssh_agent_start
end

# SSH keys
# ========
set -la user_keys "$HOME/.ssh/id_ed25519"
set -la user_keys "$HOME/.ssh/id_rsa"

# Add keys to agent if agent has no identities.
if not ssh-add -l > /dev/null
	for key in $user_keys
		# skip if key file doesn't exist
		if not test -f "$key"; continue; end

		# load key
		if test (uname) = "Darwin"
			ssh-add --apple-use-keychain "$key"
		else if test -n "$TMUX" # let tmux start first, esp. for remote sessions
			ssh-add "$key"
		end
	end
end

# Aliases
# =======

# rsync archive but exclude git repo
#alias rsyncg="rsync -a --exclude='.git/' --exclude-from='.gitignore'"
alias rsyncg="rsync -a --exclude='.git/'"

# Clean out (neo)vim swap files
alias clean-swp "rm -f ~/.local/share/nvim/swap/*.swp ~/.vim/swap/*.swp"

# bat is the new cat, if it exists
if command -q bat
	alias cat=bat
end

# vi is aliased to preferred editor
alias vi "$EDITOR"

# less - case insensitive search, highlight all matches, wrap search
alias less='less --ignore-case --hilite-search --search-skip-screen'

# fsl = fossil (distributed version control)
alias fsl='fossil'

# Local config
# ============
if test -f ~/.config/fish/config_local.fish
	source ~/.config/fish/config_local.fish
end

# Password Practice
# =================
if pwrem -q
	pwrem
end
