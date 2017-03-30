function ssh --wraps ssh --description 'Alias for ssh that sets TERM'
    # Get the path to the SSH command that is not a function
    set -l ssh (type --no-functions --path ssh)

    switch $TERM
    case 'tmux-256color'
        env TERM=screen-256color $ssh $argv
    case '*'
        eval $ssh $argv
    end
end
