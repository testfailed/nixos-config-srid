{ flake, pkgs, lib, ... }:

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
      interval = { Weekday = 1; Hour = 0; Minute = 0; };
      # options = "--delete-older-than 30d";
      options = "--delete-older-than 60d";
    };

    # # Turn this on to make command line easier
    # extraOptions = ''
    #   experimental-features = nix-command flakes repl-flake
    # '';

    settings = {
      max-jobs = "auto";
      experimental-features = "nix-command flakes repl-flake";
      trusted-users = [
        "root"
        # "@admin"
        (if pkgs.stdenv.isDarwin then myself else "@wheel")
      ];

      # I don't have an Intel mac.
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";

      # Nullify the registry for purity.
      flake-registry = builtins.toFile "empty-flake-registry.json" ''
        {"flakes":[],"version":2}
      '';
    };
  };
}
