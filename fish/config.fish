# bobthefish prompt options
set -g theme_color_scheme gruvbox
set -g theme_display_date no
set -g theme_display_cmd_duration no

# Environment Variables from ~/.profile
# Origin: https://github.com/albertz/dotfiles/blob/master/.config/fish/config.fish
function _import_profile -a profile
    egrep "^export " $profile | while read e
        set var (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\1/")
        set value (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\2/")

        # remove surrounding quotes if existing
        set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

        if test $var = "PATH"
            # replace ":" by spaces. this is how PATH looks for Fish
            set value (echo $value | sed -E "s/:/ /g")

            # use eval because we need to expand the value
            eval set -xg $var $value

            continue
        end

        # evaluate variables. we can use eval because we most likely just used "$var"
        set value (eval echo $value)

        #echo "set -xg '$var' '$value' (via '$e')"
        set -xg $var $value
    end
end
_import_profile ~/.profile
if test -f ~/.profile_local
    _import_profile ~/.profile_local
end

# Environment Variables
set -x -g SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
if test ! -e $SSH_AUTH_SOCK
    # If the socket doesn't exist...
    # Start the gpg-agent
    gpg-connect-agent /bye
end

# kitty completion
if type -fq kitty
    kitty + complete setup fish | source
end

# Aliases
alias rdp "xfreerdp +compression +clipboard +fonts /home-drive /cert-ignore /size:1400x1050"
alias rsyncg "rsync -a --exclude='.git/' --exclude-from='.gitignore'"

# Clean out neovim swp files
alias clean-swp "rm -f ~/.local/share/nvim/swap/*.swp"

# Tinyfugue
# Don't auto-connect on start
# Load config in xdg style
alias tf "tf -n -f~/.config/tinyfugue/config.tf"

# Allow extension via local configuration
if test -f ~/.config/fish/config_local.fish
    source ~/.config/fish/config_local.fish
end

# WeeChat
alias weechat "weechat -d $HOME/.config/weechat"

# Search DuckDuckGo
alias ddg "sr duckduckgo -browser=w3m"
