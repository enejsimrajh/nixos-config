# Configuration for Enej's Macbook
{ flake, pkgs, lib, system, ... }:
let
  inherit (flake.inputs) self;
  inherit (flake.config) users;
  inherit (lib) filter filesystem.listFilesRecursive;

  let importDir = dir: filter
    (filename: filename != "default.nix")
    (listFilesRecursive dir);
in
{
  imports = [
    self.darwinModules.default
    ( importDir ./. )
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "shiva";

  users.users = {
    ${users.enej.name}.home = "/Users/${users.enej.username}";
  };

  # Enable home-manager for users
  home-manager.users = {
    ${users.enej.name}.imports = [
      legacyPackages.${system}.homeConfigurations.${users.enej.name}.default
    ];
  };

  # environment.systemPackages = with pkgs; [
  #   dotnetCorePackages.sdk_6_0
  #   omnisharp-roslyn
  # ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix.linux-builder.enable = true;
  homebrew.enable = true;
}
