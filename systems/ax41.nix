{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.disko.nixosModules.disko
    self.nixosModules.default
    "${self}/nixos/disko/trivial.nix"
    "${self}/nixos/nix.nix"
    "${self}/nixos/self/primary-as-admin.nix"
    "${self}/nixos/docker.nix"
    # "${self}/nixos/actualism-app.nix" # TODO: actualism-app is not available
    "${self}/nixos/hedgedoc.nix"
    "${self}/nixos/github-runner.nix"
    "${self}/nixos/server/harden/basics.nix"
  ];

  nixos-flake.sshTarget = "srid@immediacy";

  system.stateVersion = "23.11";
  networking.hostName = "immediacy";
  nixpkgs.hostPlatform = "x86_64-linux";
  boot.loader.grub = {
    devices = [ "/dev/nvme0n1" ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "sd_mod"
  ];
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  # Hetzner networking
  networking.useDHCP = false;
  networking.interfaces."eth0".ipv4.addresses = [
    {
      address = "65.109.84.215"; # your IPv4 here
      prefixLength = 24;
    }
  ];
  networking.interfaces."eth0".ipv6.addresses = [
    {
      address = "2a01:4f9:3051:52d3::2"; # Your IPv6 here
      prefixLength = 64;
    }
  ];
  networking.defaultGateway = "65.109.84.193";
  networking.nameservers = [ "8.8.8.8" ];

  services.openssh.enable = true;

  programs.nix-ld.enable = true; # for vscode server
}
