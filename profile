export EDITOR=nvim
export GOPATH=$HOME/go
export FZF_DEFAULT_COMMAND='rg --color never --files --hidden --follow --glob "!.git/*"'

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Source the local profile if it exists
if [ -e ~/.profile_local ]; then
    source ~/.profile_local
fi

# vi:syntax=sh
