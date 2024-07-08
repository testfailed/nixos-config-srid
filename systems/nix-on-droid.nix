{ pkgs, flake, lib, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  # TODO: handle it
  # imports = [
  #   self.androidModules.default
  #   # "${self}/nixos/nix.nix"
  #   # "${self}/nixos/self/primary-as-admin.nix"
  #   # "${self}/nix-on-droid/zsh-completion-fix.nix"
  # ];

  environment.etcBackupExtension = ".bak-nix";

  # system.stateVersion = "23.11";
  system.stateVersion = "24.05";
  # networking.hostName = "nix-on-droid";
  # nixpkgs.hostPlatform = "aarch64-linux";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # services.openssh.enable = true;

  # environment.systemPackages = with pkgs; [
  environment.packages = with pkgs; [
    # System packages
    openssh
    vim

    # Some common stuff that people expect to have.
    procps
    killall
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  # For home-manager to work.
  # TODO: adapt it for nix-on-droid
  # users.users.${flake.config.people.myself} = {
  #   name = flake.config.people.myself;
  #   home = "/Users/${flake.config.people.myself}";
  # };

  home-manager.backupFileExtension = "bak-nix-hm";
  home-manager.useGlobalPkgs = true;
  home-manager.config =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";

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
        git
        htop
        iftop
        jq
        killall
        lesspipe
        neofetch
        neovim
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
        # nodePackages.vercel
        nodePackages.webpack-cli
        nodePackages.yalc
        nodePackages.yarn

        # #
        # # DevOps tools
        # #

        # docker
        # docker-compose

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
    };
}
