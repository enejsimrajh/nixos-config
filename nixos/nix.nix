{ flake, pkgs, lib, ... }:
{
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
    overlays = [
    ];
  };

  nix = {
    package = pkgs.nixVersions.latest;
    nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
    # Perform garbage collection weekly to maintain low disk usage
    # gc = {
    #   automatic = true;
    #   interval = lib.mkIf pkgs.stdenv.isDarwin { Weekday = 0; Hour = 0; Minute = 0; };
    #   dates = lib.mkIf pkgs.stdenv.isLinux "weekly";
    #   options = "--delete-older-than 30d";
    # };
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      max-jobs = "auto";
      trusted-users = [ "root" (if pkgs.stdenv.isDarwin then flake.config.people.myself else "@wheel") ];
    };
  };
}
