#!/bin/sh -e

if [ $(uname -o) = "FreeBSD" ]; then
	echo 'not installing terminfo on FreeBSD'
else
	tic term/screen.terminfo
	tic term/screen-256color.terminfo
	tic term/tmux.terminfo
	tic term/tmux-256color.terminfo
	tic term/xterm.terminfo
	tic term/xterm-256color.terminfo
fi
