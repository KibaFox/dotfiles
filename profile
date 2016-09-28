export EDITOR=nvim
export TERMINAL=st
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export GOPATH=$HOME/gocode

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Turn on the Nix environment if it exists and hasn't been loaded yet
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ] && [ -z ${NIX_PATH} ]
then
    source ~/.nix-profile/etc/profile.d/nix.sh
fi

# vi:syntax=sh
