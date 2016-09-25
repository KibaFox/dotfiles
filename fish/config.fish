# Turn off greeting on start
set -g -x fish_greeting ''

# Environment Variables
set -x EDITOR nvim
set -x NVIM_TUI_ENABLE_TRUE_COLOR 1
set -x GOPATH "$HOME/gocode"

# Aliases
alias rdp "xfreerdp +compression +clipboard +fonts /home-drive /cert-ignore /size:1400x1050"
alias rsyncg "rsync -a --exclude='.git/' --exclude-from='.gitignore'"

source ~/.config/fish/fish_prompt.fish

# Allow extension via local configuration
if test -f ~/.config/fish/config_local.fish
    source ~/.config/fish/config_local.fish
end
