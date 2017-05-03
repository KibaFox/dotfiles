# WeeChat

WeeChat does not make it easy to share configuration since certain
configuration files contain sensitive information (there is a [table showing
which configuration file may contain sensitive information][sensitive-config] in
their documentation).  WeeChat is also designed to be configured inside the
application instead of by the configuration files.  This approach makes it
difficult for the configuration files to be meaningful as a reference.

This document serves as my reference for how I configure WeeChat by keeping
a record of the configuration commands used.  The folder contains the
configuration files that I can share publicly.

Inspired by: [My always up-to-date WeeChat
configuration](https://gist.github.com/pascalpoitras/8406501)

[sensitive-config]: https://weechat.org/files/doc/stable/weechat_user.en.html#files_and_directories

## Installing WeeChat on Mac OS X

It's recommended to use [Homebrew](http://brew.sh/) to install WeeChat on Mac OS
X.  However, the default install doesn't enable many scripts and plugins.  The
[WeeChat FAQ describes how to install with plugins][install-osx].

I installed WeeChat with the following command:

    brew install weechat --with-aspell --with-curl --with-python --with-perl

Info on what options there are and what was enabled when installed can be found
by running:

    brew info weechat

[install-osx]: https://weechat.org/files/doc/weechat_faq.en.html#compile_osx

## Scripts

Run the following commands to install the WeeChat scripts:

    /script install buffers.pl iset.pl

### buffers.pl

This gives a sidebar to show the open buffers (channels, windows, etc).

### iset.pl

This allows configuration in an interactive manner inside of WeeChat.

## Slack (TODO)

Using [wee-slack](https://github.com/wee-slack/wee-slack) to connect to slack.
This uses the Slack API instead of the IRC gateway.

Install Python dependencies:

    pip install websocket-client

Install the wee-slack script:

    curl -O wget https://raw.githubusercontent.com/rawdigits/wee-slack/master/wee_slack.py
    mv wee_slack.py ~/.config/weechat/python/autoload/

Provide your Slack token:

    /secure set slack_token [YOUR_SLACK_TOKEN]
    /set plugins.var.python.slack_extension.slack_api_token ${sec.data.slack_token}

You can find your slack token on the [Legacy Tokens][slack-token] page and
using the "Request token" button.

[slack-token]: https://api.slack.com/custom-integrations/legacy-tokens
