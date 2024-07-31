# FIXME: not working
# { flake, config, lib, ... }:
# { flake, ... }:

let
  androidSdkModule = import ((builtins.fetchGit {
    url = "https://github.com/tadfisher/android-nixpkgs.git";
    ref = "main"; # Or "stable", "beta", "preview", "canary"
  }) + "/hm-module.nix");
in

# let
  #   # overlay = final: prev: {
  #   #   inherit (self.packages.${final.system}) android-sdk android-studio;
  #   # };
  #   and-pkgs = import flake.inputs.nixpkgs {
  #     system = "aarch64-darwin";
  #     inherit config lib;
  #     # inherit (flake) system;
  #     inherit (flake.inputs.android-nixpkgs) android-sdk android-studio;
  #   };
  # in
{
  # imports = [
  #   flake.inputs.android-nixpkgs.hmModule
  #
  #   {
  #     # inherit pkgs;
  #     pkgs = and-pkgs;
  #
  #     android-sdk.enable = true;
  #
  #     # Optional; default path is "~/.local/share/android".
  #     # android-sdk.path = "${config.home.homeDirectory}/.android/sdk";
  #
  #     android-sdk.packages = sdk: with sdk; [
  #       build-tools-34-0-0
  #       cmdline-tools-latest
  #       emulator
  #       platforms-android-34
  #       sources-android-34
  #     ];
  #   }
  # ];

  # # inherit config lib pkgs;
  # # inherit pkgs;
  # # inherit (flake) config lib pkgs;
  #
  # android-sdk.enable = true;
  #
  # # Optional; default path is "~/.local/share/android".
  # android-sdk.path = "${config.home.homeDirectory}/.android/sdk";
  #
  # android-sdk.packages = sdk: with sdk; [
  #   build-tools-34-0-0
  #   cmdline-tools-latest
  #   emulator
  #   platforms-android-34
  #   sources-android-34
  # ];

  # inherit (flake) config;

  imports = [ androidSdkModule ];

  android-sdk.enable = true;

  # Optional; default path is "~/.local/share/android".
  # android-sdk.path = "${config.home.homeDirectory}/.android/sdk";

  android-sdk.packages = sdkPkgs: with sdkPkgs; [
    build-tools-34-0-0
    cmdline-tools-latest
    emulator
    platforms-android-34
    sources-android-34
  ];
}
