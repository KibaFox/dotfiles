#!/bin/sh
set -ex

# Install Alacritty - a cross-platform, GPU-accelerated terminal emulator
# https://github.com/jwilma/alacritty

ver='v0.2.9'
dl="https://github.com/jwilm/alacritty/releases/download/$ver"


case "$(uname)" in
"Linux")
	asset="Alacritty-$ver-x86_64.tar.gz"
	curl -sSfLO "$dl/$asset"
	trap "rm $asset" EXIT
	sudo tar -xzvf $asset -C /usr/local/bin
	cat <<- EOF | sudo tee /usr/local/share/applications/alacritty.desktop
	[Desktop Entry]
	Name=Alacritty
	Comment=GPU-accelerated terminal emulator
	Exec=alacritty
	Icon=utilities-terminal
	Type=Application
	Categories=GTK;System;TerminalEmulator;
	StartupNotify=true
	EOF
	;;
*)
	echo "Platform not supported"
	exit 1
	;;
esac

# Install manual
curl -sSfLO "$dl/alacritty.1.gz"
gunzip 'alacritty.1.gz'
sudo mv 'alacritty.1' /usr/local/man/man1/
