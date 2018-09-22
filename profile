export EDITOR=nvim
export GOPATH=$HOME/go
export FZF_DEFAULT_COMMAND='rg --color never --files --hidden --follow --glob "!.git/*"'

# set PATH so it includes user's private bin directories
export PATH="$HOME/.local/bin:$GOPATH/bin:$PATH:/snap/bin"

# Source the local profile if it exists
if [ -e ~/.profile_local ]; then
    source ~/.profile_local
fi

# vi:syntax=sh
