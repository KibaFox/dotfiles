# Turn off greeting on start
set -g -x fish_greeting ''

# Environment Variables
set -x EDITOR nvim
set -x NVIM_TUI_ENABLE_TRUE_COLOR 1
set -x GOPATH "$HOME/gocode"

# Aliases
alias rdp "xfreerdp +compression +clipboard +fonts /home-drive /cert-ignore /size:1400x1050"
alias rsyncg "rsync -a --exclude='.git/' --exclude-from='.gitignore'"

# Fix the delete key when using st
# https://github.com/fish-shell/fish-shell/issues/2139#issuecomment-137228149
tput smkx ^/dev/null
function fish_enable_keypad_transmit --on-event fish_postexec
    tput smkx ^/dev/null
end

function fish_disable_keypad_transmit --on-event fish_preexec
    tput rmkx ^/dev/null
end
# end of - Fix the delete key when using st

# Allow extension via local configuration
if test -f ~/.config/fish/config_local.fish
    source ~/.config/fish/config_local.fish
end
