export EDITOR=nvim
export GOPATH=$HOME/go
export FZF_DEFAULT_COMMAND='rg --color never --files --hidden --follow --glob "!.git/*"'

# set PATH so it includes user's private bin directories
export PATH="$HOME/.local/bin:$GOPATH/bin:$PATH:/snap/bin"

# Turn on the Nix environment if it exists and hasn't been loaded yet
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ] && [ -z ${NIX_PATH} ]
then
    source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Source the local profile if it exists
if [ -e ~/.profile_local ]; then
    source ~/.profile_local
fi

# vi:syntax=sh
