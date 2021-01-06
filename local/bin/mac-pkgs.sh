#!/bin/sh -eu

if [ "$(uname -s)" != 'Darwin' ]; then
	echo 'This script only works on Mac OS!'
	exit 1
fi

if ! command -v brew; then
	echo 'Installing homebrew...'
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew upgrade --formula --ignore-pinned

brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew tap skyjake/lagrange

brew install --formula --quiet \
	bat \
	cmake \
	coreutils \
	fd \
	fish \
	git \
	git-lfs \
	go \
	golangci-lint \
	mage \
	mosh \
	neovim \
	pandoc \
	pngquant \
	pwgen \
	ripgrep \
	shellcheck \
	tmux \
	tree \
	;

brew upgrade --cask

brew install --cask --quiet \
	dash \
	drawio \
	font-fira-code \
	font-source-code-pro \
	keepingyouawake \
	lagrange \
	meld \
	uhk-agent \
	viscosity \
	;
