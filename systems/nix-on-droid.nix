{ pkgs, ... }:

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

  # environment.shellAliases = {
  #   # prefixed with 'g' (gnu tools / single).
  #   # gsed = lib.getExe pkgs.gnused; # NOTE: gsed executable is required for nvim-spectre plugin.
  #   gmake = lib.getExe pkgs.gnumake;
  #   gtar = lib.getExe pkgs.gnutar;

  #   # prefixed with 'g' (nix tools / multiple).
  #   gfind = "${pkgs.findutils}/bin/find";
  #   ggrep = "${pkgs.gnugrep}/bin/grep";

  #   nix-output-monitor = lib.getExe pkgs.nix-output-monitor;

  #   la = "l -a";
  #   nv = "nvim";
  #   v = "nvim";
  # };

  # Auto upgrade nix package and the daemon service.
  #
  # NOTE: - The option definition `services.nix-daemon.enable' in `/nix/store/hnc7qshiy94lzgl5kmxdxvcblvxqi7ll-source/systems/darwin.nix' no longer has any effect; please remove it.
  # nix-darwin now manages nix-daemon unconditionally when
  # `nix.enable` is on.
  # services.nix-daemon.enable = true;

  # For home-manager to work.
  # TODO: adapt it for nix-on-droid
  # users.users.${flake.config.people.myself} = {
  #   name = flake.config.people.myself;
  #   home = "/Users/${flake.config.people.myself}";
  # };

  home-manager.backupFileExtension = "bak-nix-hm";
  home-manager.useGlobalPkgs = true;
  home-manager.config = import ../home/default-android.nix;
}
