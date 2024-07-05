{ pkgs, ... }:

{
  home.packages = with pkgs; [

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
    # aspell
    # aspellDicts.en
    # hunspell
    # just # TODO: use it
    # ncdu
    # zsh-vi-mode # TODO: use it
    asciinema
    btop
    cheat
    cht-sh
    du-dust
    eza
    fd
    gdu
    gh
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

    # Node.js development tools
    nodejs
    # nodePackages.lerna # NOTE: build error
    nodePackages.cspell
    nodePackages.dotenv-cli
    nodePackages.dotenv-vault
    nodePackages.eslint
    nodePackages.graphql-cli
    nodePackages.neovim
    nodePackages.node-gyp
    nodePackages.nodemon
    nodePackages.npm
    nodePackages.patch-package
    nodePackages.pm2
    nodePackages.pnpm
    nodePackages.prettier
    nodePackages.prisma
    nodePackages.semver
    nodePackages.speed-test
    nodePackages.svgo
    nodePackages.ts-node
    nodePackages.vercel
    nodePackages.webpack-cli
    nodePackages.yalc
    nodePackages.yarn

    #
    # DevOps tools
    #

    docker
    docker-compose

    pre-commit
    turbo

    # NOTE: TEMP
    # terraform
    # terraform-ls
    ansible
    awscli2
    buf
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

    (nerdfonts.override {
      fonts = [
        "DejaVuSansMono"
        "FantasqueSansMono"
        "Hack"
        "IBMPlexMono"
        "JetBrainsMono"
        "Meslo"
        "Noto"
      ];
    })

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
