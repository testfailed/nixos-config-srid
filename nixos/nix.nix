{
  flake,
  pkgs,
  lib,
  ...
}:

let
  myself = flake.config.people.myself;
in
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
    # package = pkgs.nixVersions.nix_2_21;
    package = pkgs.nix;

    # Enables use of `nix-shell -p ...` etc.
    nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ];

    # Make `nix shell` etc use pinned nixpkgs.
    registry.nixpkgs.flake = flake.inputs.nixpkgs;

    # Garbage collect automatically every week
    gc = {
      user = "root";
      automatic = true;
      # interval = { Weekday = 0; Hour = 2; Minute = 0; };
      interval = {
        Weekday = 1;
        Hour = 0;
        Minute = 0;
      };
      # options = "--delete-older-than 30d";
      options = "--delete-older-than 60d";
    };

    settings = {
      max-jobs = "auto";
      experimental-features = "flakes nix-command";
      trusted-users = [
        "root"
        # "@admin"
        # "ssm"
        (if pkgs.stdenv.isDarwin then myself else "@wheel")
      ];

      always-allow-substitutes = true;

      # trusted-substituters = [
      #   "https://cache.nixos.org"
      #   "https://nix-community.cachix.org"
      #   "https://cachix.cachix.org"
      #   "https://devenv.cachix.org"
      #
      # ];
      # trusted-public-keys = [
      #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      #   "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      # ];
      #
      # fallback = false;
      # require-sigs = true;

      # I don't have an Intel mac.
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";

      # Nullify the registry for purity.
      flake-registry = builtins.toFile "empty-flake-registry.json" ''
        {"flakes":[],"version":2}
      '';
    };
  };
}
