{
  description = "testfailed's NixOS / nix-darwin configuration";

  # TODO: use a single source of truth for substituters settings.
  # nixConfig = (import ./nixos/caches/oss.nix).nix.settings;

  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
      "https://cachix.cachix.org"
      "https://devenv.cachix.org"
      # "https://nammayatri.cachix.org?priority=42"
      # "https://cache.garnix.io?priority=41"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      # "nammayatri.cachix.org-1:PiVlgB8hKyYwVtCAGpzTh2z9RsFPhIES6UKs0YB662I="
      # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    # Nixpkgs Inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    github-nix-ci.url = "github:juspay/github-nix-ci";

    # Application Inputs
    nixos-vscode-server.flake = false;
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    actualism-app.url = "github:srid/actualism-app";
    omnix.url = "github:juspay/omnix";

    # Neovim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Devshell
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };


  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      debug = true; # NOTE: for debugging.
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      imports = [
        inputs.nixos-flake.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule
        # inputs.androidSdkModule
        # inputs.android-nixpkgs

        ./users
        ./home
        ./nixos
        ./nix-darwin
      ];

      flake = {
        # Configuration for my M1 Macbook Max (using nix-darwin)
        darwinConfigurations.clv-mba-m1 =
          self.nixos-flake.lib.mkMacosSystem
            ./systems/darwin.nix;

        # Configuration for my Android Tablet (using nix-on-droid)
        nixOnDroidConfigurations.default =
          inputs.nix-on-droid.lib.nixOnDroidConfiguration {
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

      perSystem = { self', inputs', pkgs, system, config, ... }: {

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
        legacyPackages.homeConfigurations."srid@ubuntu" =
          self.nixos-flake.lib.mkHomeConfiguration pkgs {
            imports = [
              self.homeModules.common-linux
            ];
            home.username = "srid";
            home.homeDirectory = "/home/srid";
          };

        # checks.eval-tests =
        #   let tests = import ./tests/eval-tests.nix;
        #   in tests.runTests pkgs.emptyFile // { internals = tests; };

        pre-commit = {
          inherit pkgs;
          check.enable = true; # ==: true

          settings = {
            enabledPackages = [ ]; # ==: [ ]
            package = pkgs.pre-commit; # ==: pkgs.pre-commit
            default_stages = [ "pre-commit" "manual" ]; # ==: [ "pre-commit" ]
            excludes = [ ]; # ==: [ ]

            hooks = {
              # nixpkgs-fmt.enable = true;
              treefmt = {
                enable = true; # ==: false
                # package = null; # ==: null

                excludes = [ ]; # ==: [ ]
                extraPackages = [ ]; # ==: [ ]
                fail_fast = false; # ==: false
                files = ""; # ==: ""
                language = "system"; # ==: "system"
                pass_filenames = true; # ==: true
                require_serial = false; # ==: false
                stages = [ "pre-commit" "manual" ]; # ==: default_stages
                types = [ "file" ]; # ==: [ "file" ]
                verbose = false; # ==: false

                settings = {
                  formatters = [
                    pkgs.nixpkgs-fmt
                    # pkgs.ruff
                  ]; # ==: [ ]
                };
              };
            };
          };
        };

        # treefmt.config = {
        treefmt = {
          flakeCheck = true; # ==: true
          flakeFormatter = true; # ==: true
          projectRootFile = "flake.nix";

          settings = {
            formatters = [
              pkgs.nixpkgs-fmt
              # pkgs.ruff
            ]; # ==: [ ]
          };

          programs = {
            deadnix.enable = true; # ==: false
            nixpkgs-fmt.enable = true; # ==: false
            # prettier.enable = true; # ==: false
            # ruff.enable = true; # ==: false
            # shellcheck.enable = true; # ==: false
            # shfmt.enable = true; # ==: false
            # taplo.enable = true; # ==: false
            # yamlfmt.enable = true; # ==: false
          };
        };

        packages.default = self'.packages.activate;

        devShells.default = pkgs.mkShell {
          inputsFrom = [ config.treefmt.build.devShell ];

          nativeBuildInputs = with pkgs; [
            # hci
            nixpkgs-fmt
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
