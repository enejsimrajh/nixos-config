{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "brahma";

  system.stateVersion = "23.11";
}
