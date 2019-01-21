# My WeeChat Configuration

Inspired by [My always up-to-date WeeChat
configuration](https://gist.github.com/pascalpoitras/8406501).

## Keybindings

Set the current buffer as read with `ctrl-S` + `ctrl-B`.

    /key bind ctrl-Sctrl-B /input set_unread_current_buffer

## Slack

    /set plugins.var.python.slack.slack_api_token ${sec.data.slack_token}

Add aliases to load and unload the script.  This allows you to disconnect and
reconnect.

    /alias add lslack /script load wee_slack.py
    /alias add uslack /script unload wee_slack.py

## Matrix

    /set plugins.var.lua.matrix.user ${sec.data.matrix_user}
    /set plugins.var.lua.matrix.password ${sec.data.matrix_pass}

Add aliases to load and unload the script.  This allows you to disconnect and
reconnect.

    /alias add lmatrix /script load matrix.lua
    /alias add umatrix /script unload matrix.lua

## ZNC

Allow `/znc` commands:

    /alias add znc /quote znc

## IRCv3

    /set irc.server_default.capabilities account-notify,away-notify,cap-notify,multi-prefix,server-time,znc.in/server-time-iso,znc.in/self-message
