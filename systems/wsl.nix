# See nixos/default.nix for other modules in use.

{ pkgs, flake, ... }:
{
  imports = [
    flake.inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = flake.config.people.myself;
  };

  system.stateVersion = "23.11";
}