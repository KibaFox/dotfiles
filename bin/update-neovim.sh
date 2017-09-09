#!/bin/sh

# Only run if neovim is installed
if type nvim > /dev/null 2>&1; then
    # Install Neovim spelling dictionary and suggestions
    mkdir -p ~/.config/nvim/spell

    if ! [ -f ~/.config/nvim/spell/en.utf-8.spl ]; then
        curl -o ~/.config/nvim/spell/en.utf-8.spl \
        ftp://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl
    fi

    if ! [ -f ~/.config/nvim/spell/en.utf-8.sug ]; then
        curl -o ~/.config/nvim/spell/en.utf-8.sug \
        ftp://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.sug
    fi

    # Keep vim-plug updated and install or update neovim plugins
    nvim -i NONE -c PlugClean! -c PlugUpdate -c quitall > /dev/null

    # Install python neovim interface
    if type pip3 > /dev/null 2>&1; then
        pip3 install --upgrade neovim
    fi
    if type pip2 > /dev/null 2>&1; then
        pip2 install --upgrade neovim
    fi
fi
