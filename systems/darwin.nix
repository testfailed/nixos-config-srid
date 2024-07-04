{ pkgs, lib, flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
    "${self}/nix-darwin/zsh-completion-fix.nix"
    "${self}/nixos/github-runner.nix"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # TODO: Set your locale.
  # i18n.defaultLocale = "en_US.UTF-8";
  # config.i18n.supportedLocales = [ "all" ];

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=300
  '';

  security.pam.enableSudoTouchIdAuth = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # # Setup user, packages, programs
  # nix = {
  #   package = pkgs.nix;
  #   # package = pkgs.nixVersions.nix_2_21;
  #   # settings.trusted-users = [ "@admin" "${user}" ]; # TODO: not working
  #
  #   gc = {
  #     user = "root";
  #     automatic = true;
  #     interval = { Weekday = 0; Hour = 2; Minute = 0; };
  #     options = "--delete-older-than 30d";
  #   };
  #
  #   # Turn this on to make command line easier
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  environment.systemPackages = with pkgs; [
    # macOS GUI programs
    # wezterm

    # GNU Tools
    # coreutils-full
    # findutils
    # gnugrep
    # gnumake
    # gnused
    # gnutar
    bash-completion
    bashInteractive
    bc
    coreutils-prefixed
    curlFull
    gawkInteractive
    gnupg
    man
    openssh
    tree
    unrar
    unzip
    util-linux
    wget
    xclip
    xdg-ninja
    xdg-utils
    xsel
    zip
  ];

  networking.hostName = "clv-mba-m1";


  environment.shellAliases = {
    # prefixed with 'g' (gnu tools / single).
    # gsed = lib.getExe pkgs.gnused; # NOTE: gsed executable is required for nvim-spectre plugin.
    gmake = lib.getExe pkgs.gnumake;
    gtar = lib.getExe pkgs.gnutar;

    # prefixed with 'g' (nix tools / multiple).
    gfind = "${pkgs.findutils}/bin/find";
    ggrep = "${pkgs.gnugrep}/bin/grep";

    nix-output-monitor = lib.getExe pkgs.nix-output-monitor;

    la = "l -a";
    nv = "nvim";
    v = "nvim";
  };

  # environment.shellAliases = {
  #   # ggrep = lib.getExe pkgs.gnugrep;
  #   # gsed = lib.getExe pkgs.gnused;
  #   # nix-output-monitor = lib.getExe pkgs.nix-output-monitor;
  #
  #   la = "l -a";
  # };

  # Enable fonts dir
  fonts.fontDir.enable = true;

  # For home-manager to work.
  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    home = "/Users/${flake.config.people.myself}";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # system.stateVersion = 4;

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 36;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    # keyboard = {
    #   enableKeyMapping = true;
    #   # remapCapsLockToControl = true;
    #   remapCapsLockToControl = false;
    # };
  };
}
