#!/bin/sh -eu

if [ "$(uname -s)" != 'Darwin' ]; then
	echo 'This script only works on Mac OS!'
	exit 1
fi

if ! command -v brew; then
	echo 'Installing homebrew...'
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew install \
	awscli \
	bat \
	dep \
	dust \
	fish \
	git \
	git-archive-all \
	git-lfs \
	go \
	hashcat \
	jq \
	libpq \
	mage \
	mitmproxy \
	mosh \
	mysql-client \
	neovim \
	packer \
	pandoc \
	pngquant \
	protobuf \
	pwgen \
	ripgrep \
	shellcheck \
	tmux \
	tree \
	vault \
	;

brew upgrade

brew cask install \
	blackhole \
	dash \
	docker \
	drawio \
	font-fira-code \
	font-source-code-pro \
	gimp \
	gpg-suite \
	keepassxc \
	keepingyouawake \
	nextcloud \
	prolific-pl2303 \
	uhk-agent \
	viscosity \
	wireshark \
	;

brew cask upgrade
