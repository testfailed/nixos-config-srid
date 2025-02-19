{
  flake,
  pkgs,
  ...
}:

{

  # { flake, pkgs, ... }:
  #
  # {
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
    overlays = [
      (import ../packages/overlay.nix {
        inherit flake;
        inherit (pkgs) system;
      })
    ];
  };

  nix = {
    enable = false;
  };

  # nix = {
  #   enable = true;
  #   # package = pkgs.nixVersions.nix_2_21;
  #   package = pkgs.nix;
  #
  #   # Enables use of `nix-shell -p ...` etc.
  #   nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ];
  #
  #   # Make `nix shell` etc use pinned nixpkgs.
  #   registry.nixpkgs.flake = flake.inputs.nixpkgs;
  #
  #   # Garbage collect automatically every week
  #   gc = {
  #     # NOTE: - The option definition `nix.gc.user' in `/nix/store/hnc7qshiy94lzgl5kmxdxvcblvxqi7ll-source/nixos/nix.nix' no longer has any effect; please remove it.
  #     # The garbage collection service now always runs as `root`.
  #     # user = "root";
  #     automatic = true;
  #     # interval = { Weekday = 0; Hour = 2; Minute = 0; };
  #     interval = {
  #       Weekday = 1;
  #       Hour = 0;
  #       Minute = 0;
  #     };
  #     # options = "--delete-older-than 30d";
  #     options = "--delete-older-than 60d";
  #   };
  #
  #   settings = {
  #     max-jobs = "auto";
  #     experimental-features = "flakes nix-command";
  #     trusted-users = [
  #       "root"
  #       # "@admin"
  #       # "ssm"
  #       (if pkgs.stdenv.isDarwin then myself else "@wheel")
  #     ];
  #
  #     always-allow-substitutes = true;
  #
  #     # I don't have an Intel mac.
  #     extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
  #
  #     # Nullify the registry for purity.
  #     flake-registry = builtins.toFile "empty-flake-registry.json" ''
  #       {"flakes":[],"version":2}
  #     '';
  #   };
  # };
}
