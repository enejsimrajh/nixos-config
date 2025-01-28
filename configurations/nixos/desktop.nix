{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    "${self}/nixos/hyprland.nix"
  ];

  system.stateVersion = "23.11";
}
