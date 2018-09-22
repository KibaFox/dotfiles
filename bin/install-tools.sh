#!/bin/sh
set -ex

# Install script to install tools and utilities commonly used.
# Currently only supports MacOS and doesn't check things are already installed.

weechat=$HOME/.weechat
# weechat (w/ support for matrix)
brew install lua
# Use a downgraded version of lua-cjson https://stackoverflow.com/a/50499755
luarocks install lua-cjson 2.1.0-1
brew install weechat --with-lua

# wee-slack dependencies
pip install -U websocket-client

mkdir -p $weechat/python $weechat/lua
# download wee-slack
curl -fsSo $weechat/python/wee_slack.py \
	https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py
# download matrix
curl -fsSo $weechat/lua/matrix.lua \
	https://raw.githubusercontent.com/torhve/weechat-matrix-protocol-script/master/matrix.lua

# surfraw
brew install surfraw
