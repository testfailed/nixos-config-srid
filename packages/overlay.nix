{ flake, system, ... }:

final: prev: {
  fuckport = final.callPackage ./fuckport.nix { };
  twitter-convert = final.callPackage ./twitter-convert { };
  sshuttle-via = final.callPackage ./sshuttle-via.nix { };
  om-ci-build-remote = final.callPackage (import ./om-ci-build-remote.nix {
    inherit (flake) inputs;
  }) { };
  ci = final.callPackage ./ci { };
  # nix-health = flake.inputs.nix-browser.packages.${system}.nix-health;
  # actualism-app = flake.inputs.actualism-app.packages.${system}.default; # TODO: actualism-app is not available
  omnix = flake.inputs.omnix.packages.${system}.default;

  clisp = prev.clisp.overrideAttrs (_oldAttrs: {
    # version = "2.50pre20230112";
    # version = "2.49.95-unstable-2024-12-28";
    src = prev.fetchFromGitLab {
      rev = "c3ec11bab87cfdbeba01523ed88ac2a16b22304d";
      # hash = "sha256-xXGx2FlS0l9huVMHqNbcAViLjxK8szOFPT0J8MpGp9w=";
      hash = "";
    };
  });
}
