# Running

These are instructions for running the configuration programmatically after
a little one-time initial setup.

## Installing on Ubuntu

Example is for `bionic` or Ubuntu 18.04.
```
sudo apt-get purge weechat
sudo apt-get install apt-transport-https
sudo apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
sudo bash -c "echo 'deb https://weechat.org/ubuntu bionic main' > /etc/apt/sources.list.d/weechat.list"
sudo apt-get update
sudo apt-get install weechat-curses weechat-plugins weechat-python
```

## Initial Setup

The initial setup should not have to be run often.

Securely store sensitive configuration values.

```
/secure passphrase <pass>
/secure set slack_token <token>
/secure set matrix_user <user>
/secure set matrix_pass <pass>
/secure set matrix_server <url>
/secure set ac_fox_pass <pass>
/secure set znc_pass <pass>
```

Install scripts.

```
/script install autosort.py go.py
```

## Update Configuration

To update the configuration from the `myweechat.md` file, run the following:

```
/eval /exec -oc sed -E 's/^ *//;/^\//!d' ${env:HOME}/lib/dotfiles/weechat/myweechat.md
/eval /exec -oc sed -E 's/^ *//;/^\//!d' ${env:HOME}/lib/dotfiles-local/weechat/myweechat_local.md
/save
```
