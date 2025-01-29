# Configuration for virtual machines running under WSL

{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = flake.config.people.myself;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "yama";

  system.stateVersion = "23.11";
}
