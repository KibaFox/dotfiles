function fzman
    apropos . | fzf $FZF_DEFAULT_OPTS -d '(' -n 1 | \
        cut -d '(' -f 1 | read -l page
    man $page
end
