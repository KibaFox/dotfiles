# Dotfiles

My personal collection of dotfiles.

I took inspiration from Anish Athalye's [guide on dotfiles management][guide].

[guide]: http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
[dotbot]: https://github.com/anishathalye/dotbot

## Installing

Here is how I currently install my dotfiles:

```
git clone https://git.sr.ht/~kiba/dotfiles ~/dotfiles
git -C ~/dotfiles remote set-url --push origin git@git.sr.ht:~kiba/dotfiles
cd ~/dotfiles
go run install.go
```
## Dependencies

Must have:

- [fish](https://fishshell.com) for shell and scripts.  It provides auto-suggestions, easier history navigation, a git-aware prompt, sane scripting, and good defaults that minimize configuration.
- [fzf](https://github.com/junegunn/fzf) 0.23.0 or higher, for fuzzy file finding.
- [go](https://golang.org) 1.13 or higher, to run `install.go`; a cross-platform solution to link dotfiles.
- [nvim (neovim)](https://neovim.io) 5.0.0 or higher, for editing.
- [rg (ripgrep)](https://github.com/BurntSushi/ripgrep) for recursive directory search.
- [tmux](https://github.com/tmux/tmux) for spawning and managing terminals in a tiled fashion.

Optional:

- [bat](https://github.com/sharkdp/bat) for syntax highlighting files.
- [mosh](https://mosh.org) for remote shell connections that can disconnect and reattach.  Especially useful for tablets and laptops that go to sleep or change networks.
