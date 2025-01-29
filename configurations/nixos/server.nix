{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
  ];

  networking = {
    hostName = "web";
    domain = "lan";
    firewall.allowedTCPPorts = [ 22 80 443 ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.11";
}
