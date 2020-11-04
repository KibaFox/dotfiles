# Prompt settings
# ===============
# bobthefish prompt options
set -g theme_color_scheme gruvbox
#set -g theme_display_date no
#set -g theme_display_cmd_duration no

# Environment Variables
# =====================
set -x EDITOR nvim
set -x PAGER less
set -x GOPATH "$HOME/go"
set -x FZF_DEFAULT_COMMAND 'rg --color never --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/rgrc"
set -x BAT_CONFIG_PATH "$HOME/.config/bat/batrc"

# mosh-server sessions timeout after one week
set -x MOSH_SERVER_NETWORK_TMOUT '604800'
# mosh-server inactive sessions can be killed with: pkill -SIGUSR1 mosh-server
set -x MOSH_SERVER_SIGNAL_TMOUT '28800'

# Set PATH so it includes user's private bin directories (if they exist)
set -la user_paths "$HOME/.local/bin"
set -la user_paths "$GOPATH/bin"
set -la user_paths "/usr/local/go/bin"
for dir in $user_paths
	if test -d "$dir"
		set -ga fish_user_paths "$dir"
	end
end

# Fisher
# ======
if not functions -q fisher
	set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
	curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
	fish -c fisher
end

# To install prompt...
# fisher add github.com/oh-my-fish/theme-bobthefish

# SSH Agent
# =========
fish_ssh_agent

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

# SSH keys
# ========
set -la user_keys "$HOME/.ssh/id_ed25519"
set -la user_keys "$HOME/.ssh/id_rsa"

# See if the key is already loaded into ssh-agent
# Checks the public key comment against the comment displayed in `ssh-add -l`
set -l loaded_keys (ssh-add -l | cut -d ' ' -f 3)
for key in $user_keys
	if not test -f "$key"; continue; end

	set -l key_comment (cut -d ' ' -f 3 "$key.pub")
	if not contains "$key_comment" $loaded_keys
		if test (uname) = "Darwin"
			ssh-add -K "$key"
		else
			ssh-add "$key"
		end
	end
end

# Aliases
# =======
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ldot='git --git-dir=$HOME/.dotfiles-local/ --work-tree=$HOME'

# rsync archive but exclude git repo
alias rsyncg "rsync -a --exclude='.git/' --exclude-from='.gitignore'"

# Clean out neovim swp files
alias clean-swp "rm -f ~/.local/share/nvim/swap/*.swp"

# Local config
# ============
if test -f ~/.config/fish/config_local.fish
	source ~/.config/fish/config_local.fish
end

# Password Practice
# =================
pwrem
