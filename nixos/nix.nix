{ flake, pkgs, lib, ... }:
{
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
    overlays = [
      flake.inputs.nuenv.overlays.nuenv
      flake.inputs.nixd.overlays.default
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true; # Turn on periodic optimisation of the nix store
    settings = {
      experimental-features = "nix-command flakes repl-flake";
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      max-jobs = "auto";
      trusted-users = [ "root" (if pkgs.stdenv.isDarwin then flake.config.people.myself else "@wheel") ];
    };
  };
}