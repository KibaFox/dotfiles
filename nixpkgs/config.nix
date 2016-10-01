{ pkgs }:

{
  allowBroken = false;
  allowUnfree = true;

  # Verify new pkgs with this on before submitting a pull request to nixpkgs
  #build-use-sandbox = true;

  packageOverrides = pkgs : rec {

    st = with pkgs; pkgs.st.override {
      conf = builtins.readFile ../st/config.def.h;
    };

    # Use gnupg without gui
    # Pin to gnupg20 since gnupg21 has a bug where it won't import my keys
    gnupg = with pkgs; gnupg20.override {
      pinentry = pkgs.pinentry_ncurses;
      x11Support = false;
    };

    # Bundle collections of packages.
    # https://nixos.org/wiki/Howto_keep_multiple_packages_up_to_date_at_once
    # Gilligan's nixpks configuration: https://github.com/gilligan/nixconfig

    toolsEnv = with pkgs; buildEnv {
      name = "toolsEnv";
      paths = [
        bind            # Provides nslookup, dig
        dos2unix        # Convert between dos and unix line endings
        git             # Source control
        gnupg           # GnuPG for encrypting and signing
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

