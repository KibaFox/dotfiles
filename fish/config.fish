# Prompt settings
# ===============
# bobthefish prompt options
set -g theme_color_scheme gruvbox
#set -g theme_display_date no
#set -g theme_display_cmd_duration no

# Environment Variables
# =====================
set -x EDITOR nvim
set -x GOPATH "$HOME/go"
set -x FZF_DEFAULT_COMMAND 'rg --color never --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'

# Set PATH so it includes user's private bin directories (if they exist)
set -la user_paths "$HOME/.local/bin"
set -la user_paths "$GOPATH/bin"
set -la user_paths "/snap/bin"
set -la user_paths "/usr/local/go/bin"
set -la user_paths "$HOME/mobiledev/flutter/bin"
set -la user_paths "$HOME/mobiledev/android-studio/bin"
set -la user_paths "/usr/local/opt/mysql-client/bin"
for dir in $user_paths
	if test -d "$dir"
		set -ga fish_user_paths "$dir"
	end
end

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

# Completions
# ===========

# kitty completion
# ----------------
if type -fq kitty
	kitty + complete setup fish | source
end

# Aliases
# =======
alias rdp "xfreerdp +compression +clipboard +fonts /home-drive /cert-ignore /size:1400x1050"
alias rsyncg "rsync -a --exclude='.git/' --exclude-from='.gitignore'"

# Clean out neovim swp files
alias clean-swp "rm -f ~/.local/share/nvim/swap/*.swp"

# WeeChat
alias weechat "weechat -d $HOME/.config/weechat"

# Search DuckDuckGo
alias ddg "sr duckduckgo -browser=w3m"

# Local config
# ============
if test -f ~/.config/fish/config_local.fish
	source ~/.config/fish/config_local.fish
end
