{ pkgs, ... }:

{
  # TODO: impl

  # home.stateVersion = "22.11";

  # imports = [
  #   ./_packages.nix
  #   ./xdg.nix

  #   inputs.nixvim.homeManagerModules.nixvim
  #   inputs.nix-index-database.hmModules.nix-index

  #   # # ./helix.nix
  #   # # ./nushell.nix
  #   # # ./powershell.nix
  #   # ./juspay.nix
  #   # ./just.nix
  #   # ./nix.nix
  #   # ./starship.nix
  #   # ./terminal.nix
  #   # ./zellij.nix

  #   ./nixvim

  #   ./alacritty.nix
  #   ./bat.nix
  #   ./direnv.nix
  #   ./fzf.nix
  #   ./git.nix
  #   ./gnutools.nix
  #   ./nix-index.nix
  #   ./ripgrep.nix
  #   ./ssh.nix
  #   ./tmux.nix
  #   ./zoxide.nix
  #   ./zsh.nix
  # ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [

    # TODO: handle it with home-manager.
    bat
    neovim
    tmux

    # Nix-related tools
    nh
    nix-output-monitor
    nix-prefetch
    nix-prefetch-github

    # Encryption and security tools
    # bitwarden # NOTE: error on macOS (linux/capability.h is required in order to build libcap-ng)
    age
    age-plugin-yubikey
    # bitwarden-cli
    # bws
    libfido2

    # GNU Tools
    # NOTE: GNU tools are moved to 'systems/<system>.nix' for prefixing.

    # General packages for development and system management
    # asciinema # TODO: broken # REF: <https://discourse.nixos.org/t/error-nose-1-3-7-not-supported-for-interpreter-python3-12/48703/3?u=testfailed>
    # aspell
    # aspellDicts.en
    # hunspell
    # just # TODO: use it
    # ncdu
    # zsh-vi-mode # TODO: use it
    btop
    cheat
    cht-sh
    du-dust
    eza
    fd
    gdu
    gh
    git
    htop
    iftop
    jq
    killall
    lesspipe
    neofetch
    nufmt
    nushell
    sesh
    silver-searcher
    sqlite
    uutils-coreutils
    watchman
    yq-go

    #
    # Development tools
    #

    # Python packages
    python311 # NOTE: try python-rewrite
    python311Packages.virtualenv # globally install virtualenv

    # Node.js
    # nodejs
    nodejs_22

    # nodePackages.lerna # NOTE: build error
    # nodePackages.neovim
    # nodePackages.nodemon
    # nodePackages.prettier
    # nodePackages.semver
    # nodePackages.speed-test
    # nodePackages.svgo
    # nodePackages.ts-node
    # nodePackages.vercel
    # nodePackages.webpack-cli
    # nodePackages.yalc
    # nodePackages.yarn
    # patch-package

    # nodePackages."@prisma/language-server"
    # nodePackages.cspell
    # nodePackages.eslint
    # nodePackages.graphql-cli
    # nodePackages.node-gyp
    # nodePackages.npm
    # nodePackages.pm2
    nodePackages.pnpm
    nodePackages.prisma

    #
    # DevOps tools
    #

    # docker
    # docker-compose

    pre-commit
    turbo

    # NOTE: TEMP
    # buf
    # terraform
    # terraform-ls
    ansible
    awscli2
    cachix
    chezmoi
    google-cloud-sdk
    kubectl
    redis
    vultr-cli

    # Productivity tools
    # sc-im # TODO: build fails with deprecated error => formats/ods.c:85:9: warning: 'zip_error_to_str' is deprecated: use 'zip_error_strerror' instead [-Wdeprecated-declarations]
    # obsidian # TODO: outdated for darwin.

    # Media-related packages
    # dejavu_fonts
    # hack-font
    # jetbrains-mono
    # meslo-lgs-nf
    # noto-fonts
    # noto-fonts-emoji
    emacs-all-the-icons-fonts
    ffmpeg
    font-awesome
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    # (nerdfonts.override {
    #   fonts = [
    #     "DejaVuSansMono"
    #     "FantasqueSansMono"
    #     "Hack"
    #     "IBMPlexMono"
    #     "JetBrainsMono"
    #     "Meslo"
    #     "Noto"
    #   ];
    # })

    # NOTE: for nixpkgs-25.05
    nerd-fonts.blex-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.noto

    # Etc.
    fortune

    # ] ++ (lib.optionals isDarwin [
    #   # This is automatically setup on Linux
    #   pkgs.cachix
    #   pkgs.tailscale
    # ]) ++ (lib.optionals (isLinux && !isWSL) [
    #   pkgs.chromium
    #   pkgs.firefox
    #   pkgs.rofi
    #   pkgs.valgrind
    #   pkgs.zathura
    #   pkgs.xfce.xfce4-terminal
  ];
}
