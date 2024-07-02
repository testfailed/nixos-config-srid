{
  description = "testfailed's NixOS / nix-darwin configuration";

  inputs = {
    # Principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    # nixos-flake.url = "github:srid/nixos-flake";
    nixos-flake.url = "github:testfailed/nixos-flake-srid/dev-testfailed";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    colmena-flake.url = "github:juspay/colmena-flake";

    # Software inputs
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

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      # NOTE: for debugging.
      debug = true;

      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.nixos-flake.flakeModule
        inputs.colmena-flake.flakeModules.default
        ./users
        ./home
        ./nixos
        ./nix-darwin
      ];

      # Colmena deployment configuration
      # See https://github.com/juspay/colmena-flake
      colmena-flake.deployment =
        let
          read1Password = field:
            [ "op" "read" "op://Personal/nixos-config/${field}" ];
        in
        {
          immediacy = {
            targetHost = "immediacy";
            targetUser = "srid";
            keys."hedgedoc.env" = {
              user = "hedgedoc";
              keyCommand = read1Password "hedgedoc.env";
            };
          };
          github-runner =
            let
              user = "github-runner";
            in
            {
              targetHost = "github-runner";
              targetUser = "srid";
              keys = {
                "github-runner-token.secret" = {
                  inherit user;
                  keyCommand = read1Password "github-runner-token";
                };
                "nix-conf-gh-token.secret" = {
                  user = "root";
                  permissions = "0440";
                  keyCommand = read1Password "nix-conf-gh-token";
                };
              };
            };
        };

      flake = {
        # Configuration for my M1 Macbook Max (using nix-darwin)
        darwinConfigurations.clv-mba-m1 =
          self.nixos-flake.lib.mkMacosSystem
            ./systems/darwin.nix;

        # Configuration for a NixOS VM (running on my Mac)
        nixosConfigurations.github-runner =
          self.nixos-flake.lib.mkLinuxSystem
            ./systems/github-runner.nix;

        # Hetzner dedicated
        nixosConfigurations.immediacy =
          self.nixos-flake.lib.mkLinuxSystem
            ./systems/ax41.nix;
      };

      perSystem = { self', pkgs, system, config, ... }: {
        # Flake inputs we want to update periodically
        # Run: `nix run .#update`.
        nixos-flake.primary-inputs = [
          "nixpkgs"
          "home-manager"
          "nix-darwin"
          "nixos-flake"
          "nix-index-database"
          "nixvim"
        ];

        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.nixpkgs-fmt.enable = true;
        };
        formatter = config.treefmt.build.wrapper;

        packages.default = self'.packages.activate;

        devShells.default = pkgs.mkShell {
          inputsFrom = [ config.treefmt.build.devShell ];
          packages = with pkgs; [
            # just
            colmena
            nixd
          ];
        };

        # Make our overlay available to the devShell
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            (import ./packages/overlay.nix {
              inherit system;
              flake = { inherit inputs; };
            })
          ];
        };
      };
    };
}
