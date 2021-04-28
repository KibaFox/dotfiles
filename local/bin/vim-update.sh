#!/bin/sh -eux

# Keep vim-plug updated and install or update plugins
vim -i NONE -c PlugClean! -c PlugUpdate -c quitall > /dev/null
