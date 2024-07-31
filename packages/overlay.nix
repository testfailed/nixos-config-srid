{ flake, system, ... }:

final: _: {
  fuckport = final.callPackage ./fuckport.nix { };
  twitter-convert = final.callPackage ./twitter-convert { };
  sshuttle-via = final.callPackage ./sshuttle-via.nix { };
  om-ci-build-remote = final.callPackage (import ./om-ci-build-remote.nix { inherit (flake) inputs; }) { };
  ci = final.callPackage ./ci { };
  # nix-health = flake.inputs.nix-browser.packages.${system}.nix-health;
  actualism-app = flake.inputs.actualism-app.packages.${system}.default;
  omnix = flake.inputs.omnix.packages.${system}.default;
}
