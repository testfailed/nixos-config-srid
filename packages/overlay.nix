{ flake, system, ... }:

final: _: {
  fuckport = final.callPackage ./fuckport.nix { };
  twitter-convert = final.callPackage ./twitter-convert { };
  sshuttle-via = final.callPackage ./sshuttle-via.nix { };
  nixci = flake.inputs.nixci.packages.${system}.default;
  # nix-health = flake.inputs.nix-browser.packages.${system}.nix-health;
  actualism-app = flake.inputs.actualism-app.packages.${system}.default;
}
