{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Nix-related tools
    cachix
    devenv
    fh
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
    delta
    difftastic
    du-dust
    dua
    eza
    fd
    hexyl
    hwatch
    hyperfine
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
    xsv
    yq-go

    #
    # Development tools
    #

    nickel
    nls

    # REST API Testing Tools
    # postman
    newman

    # Python
    python311 # NOTE: try python-rewrite
    python311Packages.virtualenv # globally install virtualenv

    # Java
    temurin-bin-21
    gradle
    maven

    # Android
    android-tools
    # android-studio
    # android-studio-full

    # Node.js
    nodejs

    # nodePackages.lerna # NOTE: build error
    # nodePackages.neovim
    # nodePackages.yarn
    nodePackages."@prisma/language-server"
    nodePackages.cspell
    nodePackages.eslint
    nodePackages.graphql-cli
    nodePackages.node-gyp
    nodePackages.nodemon
    nodePackages.npm
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
    patch-package

    dotenv-cli
    dotenvx
    nodePackages.dotenv-vault

    # Rust
    # TODO: setup with fenix
    # REF: <https://github.com/nix-community/fenix/>
    # cargo
    # rust
    # rustfmt

    #
    # DevOps tools
    #

    # NOTE: docker is install/configured in 'nixos/docker.nix'
    # docker
    # docker-compose
    # docker_27

    pre-commit
    turbo

    # NOTE: TEMP
    # buf
    # terraform
    # terraform-ls
    ansible
    awscli2
    chezmoi
    google-cloud-sdk
    kubectl
    # mosh
    redis
    tailscale
    vultr-cli
    nginx

    #
    # Other Development tools
    #
    elixir
    go

    # Productivity tools
    # sc-im # TODO: build fails with deprecated error => formats/ods.c:85:9: warning: 'zip_error_to_str' is deprecated: use 'zip_error_strerror' instead [-Wdeprecated-declarations]
    # obsidian # TODO: outdated for darwin.
    graphviz

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

    # NOTE: for nixpkgs-25.05
    # nerd-fonts.blex-mono
    # nerd-fonts.dejavu-sans-mono
    # nerd-fonts.fantasque-sans-mono
    # nerd-fonts.hack
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.meslo-lg
    # nerd-fonts.noto

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
