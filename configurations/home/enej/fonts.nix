{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];
}
