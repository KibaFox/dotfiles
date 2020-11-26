# Dotfiles

My personal collection of dotfiles.

I took inspiration from Anish Athalye's [guide on dotfiles management][guide]
and use [Dotbot][dotbot] for installation.

[guide]: http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
[dotbot]: https://github.com/anishathalye/dotbot

## Installing

Here is how I currently install my dotfiles:

```
git clone https://git.sr.ht/~kiba/dotfiles ~/dotfiles
git -C ~/dotfiles remote set-url --push origin git@git.sr.ht:~kiba/dotfiles
~/dotfiles/install
```
