export EDITOR=nvim
export GOPATH=$HOME/go
export FZF_DEFAULT_COMMAND='find . -path '\''*/\.*'\'' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//'

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
