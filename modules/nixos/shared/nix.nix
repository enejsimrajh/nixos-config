{ flake, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  nix = {
    nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc
    optimise.automatic = true;
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
    settings = {
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin";
      trusted-users = [ "root" "@admin" "@wheel" ];
    };
  };
}
