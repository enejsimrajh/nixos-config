{ pkgs, ... }:
{
  programs.firefox = {
    package = if pkgs.stdenv.isDarwin then null else pkgs.firefox-bin;
  };
}
