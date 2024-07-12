# { config, pkgs, ... }:
{
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
    # nix-direnv.package = pkgs.nix-direnv.override { nix = config.nix.package; };

    config.global = {
      hide_env_diff = true;
    };
  };
}
