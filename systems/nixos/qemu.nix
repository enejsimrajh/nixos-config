# Configuration for virtual machines running under QEMU

{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    #self.nixosModules.default
    #"${self}/nixos/acme.nix"
    "${self}/nixos/nginx.nix"
    "${self}/nixos/cgit.nix"
  ];

  # Configure networking
  networking = {
    hostName = "maya";
    firewall.enable = false;
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
  };

  virtualisation = {
    vmVariant.virtualisation = {
      graphics = false;
      forwardPorts = [
        {
          from = "host";
          host.port = 8080;
          guest.port = 80;
        }
      ];
    };
  };

  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  services.getty.autologinUser = flake.config.people.myself;
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.11";
}
