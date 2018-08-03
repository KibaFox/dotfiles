# Running

These are instructions for running the configuration programmatically after
a little one-time initial setup.

## Initial Setup

The initial setup should not have to be run often.

Securely store sensitive configuration values.

```
/secure passphrase <pass>
/secure set slack_token <token>
/secure set matrix_user <user>
/secure set matrix_pass <pass>
/secure set matrix_server <url>
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
```
