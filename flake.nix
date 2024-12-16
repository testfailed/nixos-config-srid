{
  description = "testfailed's NixOS / nix-darwin configuration";

  inputs = {
    # Nixpkgs Inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2405.*";
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.*";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Determinate Systems Inputs
    # determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    # fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*";

    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-android.url = "github:nixos/nixpkgs/nixos-24.05";
    nix-on-droid.url = "github:t184256/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs-android";
    nix-on-droid.inputs.home-manager.follows = "home-manager";

    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
    android-nixpkgs.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Utility Inputs
    flake-parts.url = "github:hercules-ci/flake-parts";
    # nixos-flake.url = "github:srid/nixos-flake";
    nixos-flake.url = "github:testfailed/nixos-flake-srid/dev-testfailed";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Inputs
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.url = "github:yaxitech/ragenix";

    # CI Inputs
    # pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    git-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";
    github-nix-ci.url = "github:juspay/github-nix-ci";

    # Application Inputs
    nixos-vscode-server.flake = false;
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    # actualism-app.url = "github:srid/actualism-app"; # TODO: actualism-app is not available
    omnix.url = "github:juspay/omnix";

    # Neovim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Devshell
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      debug = true; # NOTE: for debugging.
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      imports = [
        inputs.nixos-flake.flakeModule
        # inputs.pre-commit-hooks-nix.flakeModule
        inputs.git-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule
        # inputs.androidSdkModule
        # inputs.android-nixpkgs

        # NOTE: already installed using 'Determinate.pkg'
        # inputs.determinate.darwinModules.default

        # TODO: not working
        # inputs.fh.flakeModule
        # inputs.fh.darwinModules.default

        ./users
        ./home
        ./nixos
        ./nix-darwin
      ];

      flake = {
        # Configuration for my M1 Macbook Max (using nix-darwin)
        darwinConfigurations.clv-mba-m1 = self.nixos-flake.lib.mkMacosSystem ./systems/darwin.nix;

        # Configuration for my Android Tablet (using nix-on-droid)
        nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          modules = [ ./systems/nix-on-droid.nix ];

          # set nixpkgs instance. it's recommended to apply `nix-on-droid.overlays.default`
          pkgs = import inputs.nixpkgs {
            system = "aarch64-linux";
            overlays = [
              inputs.nix-on-droid.overlays.default
            ];
          };

          # set path to home-manager flake
          home-manager-path = inputs.home-manager.outPath;
        };

        # # Hetzner dedicated
        # nixosConfigurations.immediacy =
        #   self.nixos-flake.lib.mkLinuxSystem
        #     ./systems/ax41.nix;
      };

      perSystem =
        {
          self',
          inputs',
          pkgs,
          system,
          config,
          ...
        }:
        {

          # Flake inputs we want to update periodically
          # Run: `nix run .#update`.
          nixos-flake = {
            primary-inputs = [
              "nixpkgs"
              "home-manager"
              "nix-darwin"
              "nixos-flake"
              "nix-index-database"
              "nixvim"
            ];
          };

          # # Android Development Environment (using nixpkgs-android)
          # android-sdk = .android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
          #   cmdline-tools-latest
          #   build-tools-34-0-0
          #   platform-tools
          #   platforms-android-34
          #   emulator
          # ]);

          # My Ubuntu VM
          legacyPackages.homeConfigurations."srid@ubuntu" = self.nixos-flake.lib.mkHomeConfiguration pkgs {
            imports = [
              self.homeModules.common-linux
            ];
            home.username = "srid";
            home.homeDirectory = "/home/srid";
          };

          # checks.eval-tests =
          #   let tests = import ./tests/eval-tests.nix;
          #   in tests.runTests pkgs.emptyFile // { internals = tests; };

          pre-commit.settings = {
            default_stages = [
              "pre-commit"
              "manual"
            ]; # ==: [ "pre-commit" ]

            hooks = {
              # nixfmt-rfc-style.enable = true; # ==: false # *:
              treefmt.enable = true; # ==: false # *:
            };
          };

          treefmt = {
            flakeCheck = true; # ==: true
            flakeFormatter = true; # ==: true
            projectRootFile = "flake.nix";

            settings = {
              formatters = [
                "deadnix"
                "nixfmt-rfc-style"
              ]; # ==: [ ]
            };

            programs = {
              deadnix.enable = true; # ==: false # *:
              nixfmt-rfc-style.enable = true; # ==: false # *:
              # nixfmt-rfc-style.package = pkgs.nixfmt-rfc-style;
            };
          };

          packages.default = self'.packages.activate;

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.treefmt.build.devShell ];

            nativeBuildInputs = with pkgs; [
              # hci
              nixfmt-rfc-style
              pre-commit
            ];

            packages = with pkgs; [
              # just
              colmena
              nixd
              inputs'.ragenix.packages.default
            ];

            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };

          # Make our overlay available to the devShell
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.nix-on-droid.overlays.default
              # add other overlays
            ];
          };
        };
    };

}
