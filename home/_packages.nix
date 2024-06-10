{ pkgs, ... }:
{
  home.packages = with pkgs; [

    # Nix-related tools
    nh
    nix-output-monitor
    nix-prefetch
    nix-prefetch-github

    # Encryption and security tools
    age
    age-plugin-yubikey
    libfido2

    # GNU/core tools
    bash-completion
    bashInteractive
    bc
    coreutils-prefixed
    curlFull
    findutils
    gawk
    gnugrep
    gnumake
    gnupg
    gnused
    gnutar
    man
    openssh
    tree
    unrar
    unzip
    util-linux
    wget
    xclip
    xsel
    xdg-ninja
    xdg-utils
    zip

    # General packages for development and system management
    # aspell
    # aspellDicts.en
    # hunspell
    # just # TODO: use it
    # lesspipe
    # zsh-vi-mode # TODO: use it
    alacritty
    asciinema
    btop
    cheat
    cht-sh
    eza
    fd
    fortune
    gh
    htop
    iftop
    jq
    killall
    neofetch
    nufmt
    nushell
    silver-searcher
    sqlite
    uutils-coreutils
    yq-go

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

    docker
    docker-compose

    # Python packages
    python311 # NOTE: try python-rewrite
    python311Packages.virtualenv # globally install virtualenv

    # Node.js development tools
    nodePackages.npm # globally install npm
    nodePackages.prettier
    nodejs

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
    watchman

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
