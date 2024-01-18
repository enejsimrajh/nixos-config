# See nixos/default.nix for other modules in use.

{ pkgs, flake, ... }:
{
  imports = [
    flake.inputs.nixos-wsl.nixosModules.wsl
    flake.inputs.nixos-wsl-vscode.nixosModules.vscodeServerWsl
  ];

  boot.loader.grub.device = "nodev";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
  };

  wsl = {
    enable = true;
    defaultUser = flake.config.people.myself;
  };

  system.stateVersion = "23.11";
}