# Configuration common to all Linux systems
{ flake, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports = [
    {
      home-manager.sharedModules = [
        self.homeModules.default
        self.homeModules.linux
      ];
    }
    self.homeModules.toplevel
    self.nixosModules.shared
    self.nixosModules.linux
    inputs.agenix.nixosModules.default
  ];

  services.openssh.enable = true;
}
