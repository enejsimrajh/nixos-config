# Top-level flake glue to get our configuration working
{ inputs, ... }:
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
  perSystem = { self', pkgs, ... }: {
    # Enables 'nix run' to activate.
    packages.default = self'.packages.activate;
    # For 'nix fmt'
    formatter = pkgs.nixpkgs-fmt;
    # Flake inputs we want to update periodically
    # Run: `nix run .#update`.
    nixos-unified = {
      primary-inputs = [
        "nixpkgs"
        "nixos-unified"
        "nix-darwin"
        "home-manager"
        "nix-index-database"
      ];
    };
  };
}
