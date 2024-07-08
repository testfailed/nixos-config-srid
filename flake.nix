{
  description = "testfailed's NixOS / nix-darwin configuration";

  inputs = {
    # Principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-android.url = "github:nixos/nixpkgs/nixos-24.05";
    nix-on-droid.url = "github:t184256/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs-android";
    nix-on-droid.inputs.home-manager.follows = "home-manager";

    flake-parts.url = "github:hercules-ci/flake-parts";
    # nixos-flake.url = "github:srid/nixos-flake";
    nixos-flake.url = "github:testfailed/nixos-flake-srid/dev-testfailed";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.url = "github:yaxitech/ragenix";

    # Software inputs
    github-nix-ci.url = "github:juspay/github-nix-ci";
    nixos-vscode-server.flake = false;
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixci.url = "github:srid/nixci";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    actualism-app.url = "github:srid/actualism-app";

    # Neovim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Devshell
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };


  outputs = inputs@{ self, ... }: {
    # Configuration for my Android Tablet Y700 (using nix-on-droid, termux)
    # nixOnDroidConfigurations.clv-andt-y700 =
    #   self.nixos-flake.lib.mkAndroidSystem
    #     ./systems/nix-on-droid.nix;
    nixOnDroidConfigurations.default =
      inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        # system = "aarch64-linux";
        # inherit system;
        # pkgs = inputs.nixpkgs-android;
        modules = [ ./systems/nix-on-droid.nix ];

        # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
        pkgs = import inputs.nixpkgs {
          system = "aarch64-linux";

          overlays = [
            inputs.nix-on-droid.overlays.default
            # add other overlays
          ];
        };

        # set path to home-manager flake
        home-manager-path = inputs.home-manager.outPath;
      };
  };

  # outputs = inputs@{ self, ... }:
  #   inputs.flake-parts.lib.mkFlake { inherit inputs; } {

  #     debug = true; # NOTE: for debugging.
  #     systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

  #     imports = [
  #       inputs.treefmt-nix.flakeModule
  #       # inputs.nixos-flake.flakeModule
  #       inputs.nixos-flake.flakeModule
  #       ./users
  #       ./home
  #       ./nixos
  #       ./nix-darwin
  #     ];

  #     flake = {
  #       # Configuration for my M1 Macbook Max (using nix-darwin)
  #       darwinConfigurations.clv-mba-m1 =
  #         self.nixos-flake.lib.mkMacosSystem
  #           ./systems/darwin.nix;

  #       # Configuration for a NixOS VM (running on my Mac)
  #       nixosConfigurations.github-runner =
  #         self.nixos-flake.lib.mkLinuxSystem
  #           ./systems/github-runner.nix;

  #       # Hetzner dedicated
  #       nixosConfigurations.immediacy =
  #         self.nixos-flake.lib.mkLinuxSystem
  #           ./systems/ax41.nix;
  #     };

  #     perSystem = { self', inputs', pkgs, system, config, ... }: {
  #       # My Ubuntu VM
  #       legacyPackages.homeConfigurations."srid@ubuntu" =
  #         self.nixos-flake.lib.mkHomeConfiguration pkgs {
  #           imports = [
  #             self.homeModules.common-linux
  #           ];
  #           home.username = "srid";
  #           home.homeDirectory = "/home/srid";
  #         };

  #       # Flake inputs we want to update periodically
  #       # Run: `nix run .#update`.
  #       nixos-flake = {
  #         primary-inputs = [
  #           "nixpkgs"
  #           "home-manager"
  #           "nix-darwin"
  #           "nixos-flake"
  #           "nix-index-database"
  #           "nixvim"
  #         ];
  #       };

  #       treefmt.config = {
  #         projectRootFile = "flake.nix";
  #         programs.nixpkgs-fmt.enable = true;
  #       };

  #       packages.default = self'.packages.activate;

  #       devShells.default = pkgs.mkShell {
  #         inputsFrom = [ config.treefmt.build.devShell ];
  #         packages = with pkgs; [
  #           # just
  #           colmena
  #           nixd
  #           inputs'.ragenix.packages.default
  #         ];
  #       };

  #       # Make our overlay available to the devShell
  #       _module.args.pkgs = import inputs.nixpkgs {
  #         inherit system;
  #         overlays = [
  #           (import ./packages/overlay.nix {
  #             inherit system;
  #             flake = { inherit inputs; };
  #           })
  #         ];
  #       };
  #     };
  #   };
}
