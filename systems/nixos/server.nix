{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    "${self}/nixos/acme.nix"
    "${self}/nixos/nginx.nix"
    "${self}/nixos/sourcehut.nix"
  ];

  networking = {
    hostName = "web";
    domain = "lan";
    firewall.allowedTCPPorts = [ 22 80 443 ];
  };

    system.stateVersion = "23.11";
}
