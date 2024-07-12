# NOTE: It is initial nix config before the further setup using flake configs.
{ ... }:

let
  # nixpkgs = fetch git ...
  # pkgs = import <nixpkgs> { config = {}; };
  pkgs = import <nixos-unstable> { config = { }; }; # NOTE: unstable isn't that unstable.

  # TODO: enter it before switching as you might loose the access to the server.
  authorizedKeys = [
    "{{ENTER_YOUR_SSH_PUBLIC_KEY}}"
    "{{ENTER_YOUR_SSH_PUBLIC_KEY}}"
  ];
in
{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "23.11";

  nixpkgs = {
    overlays = [
      # NOTE: Add overlays here.
    ];

    config = {
      allowUnfree = true;
    };
  };

  nix = {
    enable = true;
    package = pkgs.nix;

    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking.hostName = "{{HOSTNAME}}";
  networking.domain = "{{DOMAIN}}";

  services.openssh = {
    enable = true;
    settings = {
      # TODO: change it to "no"
      PermitRootLogin = "yes";

      # TODO: change it to false
      PasswordAuthentication = true;
    };
  };

  users.users = {
    root = {
      openssh.authorizedKeys.keys = authorizedKeys;
    };

    ssm = {
      initialPassword = "changeit";
      isNormalUser = true;
      extraGroups = [ "wheel" ];

      openssh.authorizedKeys.keys = authorizedKeys;
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    curl
    git
    jq
    neovim
    tmux
    vim
    wget
  ];
}
