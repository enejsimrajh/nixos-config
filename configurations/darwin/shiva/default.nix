# Configuration for Enej's Macbook
{ flake, pkgs, lib, ... }:
let
  inherit (flake.inputs) self;
  inherit (flake.config) users;
  inherit (lib) filter filesystem hasSuffix;
  inherit (filesystem) listFilesRecursive;

  importDir = dir: filter
    (filename: hasSuffix ".nix" filename && !(hasSuffix "default.nix" filename))
    (listFilesRecursive dir);
in
{
  imports = [
    self.darwinModules.default
  ] ++ importDir ./.;

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "shiva";

  users.users = {
    ${users.enej.username}.home = "/Users/${users.enej.username}";
  };

  # Enable home-manager for users
  home-manager.users = {
    ${users.enej.username}.imports = [
      (self + /configurations/home/${users.enej.username})
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
