# See nixos/default.nix for other modules in use.

{ pkgs, ... }:
{
  boot.loader.grub.device = "nodev";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
  };

  system.stateVersion = "23.11";
}