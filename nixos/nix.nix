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
      (import ../packages/overlay.nix { inherit flake; inherit (pkgs) system; })
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      max-jobs = "auto";
      experimental-features = "nix-command flakes repl-flake";
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      trusted-users = [ "root" (if pkgs.stdenv.isDarwin then flake.config.people.myself else "@wheel") ];
    };
  };
}