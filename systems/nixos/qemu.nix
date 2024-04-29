# Configuration for virtual machines running under QEMU

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

  # Configure networking
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  services.getty.autologinUser = flake.config.people.myself;
  security.sudo.wheelNeedsPassword = false;

  # Make VM output to the terminal instead of a separate window
  virtualisation.vmVariant.virtualisation.graphics = false;

  system.stateVersion = "23.11";
}
