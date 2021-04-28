#!/bin/sh -eux

spelldir="$HOME/.vim/spell"

# Only run if vim is installed
if type vim > /dev/null 2>&1; then
	# Install vim spelling dictionary and suggestions
	mkdir -p "$spelldir"

	if ! [ -f "$spelldir/en.utf-8.spl" ]; then
		curl -o "$spelldir/en.utf-8.spl" \
		ftp://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl
	fi

	if ! [ -f "$spelldir/en.utf-8.sug" ]; then
		curl -o "$spelldir/en.utf-8.sug" \
		ftp://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.sug
	fi

	# Keep vim-plug updated and install or update plugins
	vim -i NONE -c PlugClean! -c PlugUpdate -c quitall > /dev/null
else
	echo 'vim was not detected. Skipping neovim update...'
fi
