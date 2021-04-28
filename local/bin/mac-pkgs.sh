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

brew install --formula --quiet \
	bat \
	fish \
	git-lfs \
	go \
	golangci-lint \
	mage \
	mosh \
	pandoc \
	pngquant \
	pwgen \
	ripgrep \
	shellcheck \
	tmux \
	tree \
	;

brew upgrade --cask

brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew tap skyjake/lagrange

brew install --cask --quiet \
	dash \
	drawio \
	font-fira-code \
	keepingyouawake \
	lagrange \
	meld \
	uhk-agent \
	viscosity \
	;
