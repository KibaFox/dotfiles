#!/bin/sh -eu

if [ "$(uname -s)" != 'Darwin' ]; then
	echo 'This script only works on Mac OS!'
	exit 1
fi

if ! command -v brew; then
	echo 'Installing homebrew...'
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew upgrade --ignore-pinned

brew tap homebrew/cask-fonts d12frosted/emacs-plus

brew install --quiet \
	bat \
	coreutils \
	emacs-plus \
	fd \
	fish \
	git \
	git-lfs \
	go \
	mage \
	mosh \
	neovim \
	pandoc \
	pngquant \
	pwgen \
	ripgrep \
	shellcheck \
	tmux \
	tree  \
	;

brew cask upgrade

brew cask install \
	dash \
	drawio \
	font-fira-code \
	font-source-code-pro \
	keepingyouawake \
	meld \
	uhk-agent \
	viscosity \
	;
