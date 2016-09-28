{ pkgs }:

{
  allowBroken = false;
  allowUnfree = true;

  packageOverrides = pkgs : rec {

    st = with pkgs; (pkgs.st.override {
      conf = builtins.readFile ../st/config.def.h;
    });

    # Bundle collections of packages.
    # https://nixos.org/wiki/Howto_keep_multiple_packages_up_to_date_at_once
    # Gilligan's nixpks configuration: https://github.com/gilligan/nixconfig

    toolsEnv = with pkgs; buildEnv {
      name = "toolsEnv";
      paths = [
        (gnupg20.override { # gnupg21 will not import my keys
          pinentry = pinentry_ncurses;
          x11Support = false;
        })
        bind            # Provides nslookup, dig
        dos2unix        # Convert between dos and unix line endings
        git             # Source control
        htop            # An interactive process viewer for Linux
        lsof            # Tool to list open files
        mosh            # The mobile shell
        neovim          # Neovim, my editor of choice
        pandoc          # Universal document converter
        pngnq           # Lossy PNG compressor
        psmisc          # includes killall
        pwgen           # Password generator
        keybase         # Keybase.io client
        python
        silver-searcher # A code-searching tool similar to ack, but faster
        tmux            # Terminal multiplexer
        unzip
        wget
      ];
    };
  };
}

