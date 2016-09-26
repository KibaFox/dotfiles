{ pkgs }:

{
  allowBroken = false;
  allowUnfree = true;

  packageOverrides = pkgs : rec {

    # Bundle collections of packages.
    # https://nixos.org/wiki/Howto_keep_multiple_packages_up_to_date_at_once
    # Gilligan's nixpks configuration: https://github.com/gilligan/nixconfig

    toolsEnv = with pkgs; buildEnv {
      name = "toolsEnv";
      paths = [
        (gnupg.override {
          pinentry = pinentry_ncurses;
          x11Support = false;
        })
        bind            # Provides nslookup, dig
        dos2unix        # Convert between dos and unix line endings
        fish            # Smart and user-friendly command line shell
        git             # Source control
        htop            # An interactive process viewer for Linux
        lsof            # Tool to list open files
        mosh            # The mobile shell
        neovim          # Neovim, my editor of choice
        pandoc          # Universal document converter
        pngnq           # Lossy PNG compressor
        psmisc          # includes killall
        pwgen           # Password generator
        python
        silver-searcher # A code-searching tool similar to ack, but faster
        tmux            # Terminal multiplexer
        unzip
        wget
      ];
    };
  };
}

