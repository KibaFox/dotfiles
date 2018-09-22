# Prompt settings {{{
# bobthefish prompt options
set -g theme_color_scheme gruvbox
set -g theme_display_date no
set -g theme_display_cmd_duration no
# }}}

# Environment Variables {{{
set -x EDITOR nvim
set -x GOPATH "$HOME/go"
set -x FZF_DEFAULT_COMMAND 'rg --color never --files --hidden --follow --glob "!.git/*"'

# Set PATH so it includes user's private bin directories (if they exist)
if test -d "$HOME/.local/bin"; set PATH "$HOME/.local/bin" $PATH; end
if test -d "$GOPATH/bin"; set PATH "$GOPATH/bin" $PATH; end
if test -d "/snap/bin"; set PATH "/snap/bin" $PATH; end
# }}}

# Completions {{{

# kitty completion
if type -fq kitty
	kitty + complete setup fish | source
end
# }}}

# Aliases {{{
alias rdp "xfreerdp +compression +clipboard +fonts /home-drive /cert-ignore /size:1400x1050"
alias rsyncg "rsync -a --exclude='.git/' --exclude-from='.gitignore'"

# Clean out neovim swp files
alias clean-swp "rm -f ~/.local/share/nvim/swap/*.swp"

# Tinyfugue
# Don't auto-connect on start
# Load config in xdg style
alias tf "tf -n -f~/.config/tinyfugue/config.tf"

# WeeChat
alias weechat "weechat -d $HOME/.config/weechat"

# Search DuckDuckGo
alias ddg "sr duckduckgo -browser=w3m"

# }}}

# Local config {{{
if test -f ~/.config/fish/config_local.fish
	source ~/.config/fish/config_local.fish
end
# }}}

# vim:foldmethod=marker
