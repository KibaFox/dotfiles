Dotfiles
========

My personal collection of dotfiles.

I took inspiration from Anish Athalye's [guide on dotfiles management][guide]
and use [Dotbot][dotbot] for installation.

[guide]: http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
[dotbot]: https://github.com/anishathalye/dotbot

Installing
----------

Here is how I currently install my dotfiles:

    git clone https://github.com/KibaFox/dotfiles.git ~/lib/dotfiles
    git -C ~/lib/dotfiles remote set-url --push origin git@github.com:KibaFox/dotfiles.git
    ~/lib/dotfiles/install
