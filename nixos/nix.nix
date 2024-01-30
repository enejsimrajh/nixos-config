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
      interval = { Weekday = 0; Hour = 0; Minute = 0; };
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes repl-flake";
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      max-jobs = "auto";
      trusted-users = [ "root" (if pkgs.stdenv.isDarwin then flake.config.people.myself else "@wheel") ];
    };
  };
}