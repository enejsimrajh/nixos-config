# Platform-independent terminal setup

{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    gh
  ];

  home.shellAliases = {
    e = "code";
    g = "git";
  };

  programs = {
    zoxide.enable = true;
    nix-index.enable = true;
    htop.enable = true;
  };
}