{ pkgs, ... }:
{
  fonts = {
    fontconfig.enable = true;
  };

  home.packages = [
    (
      pkgs.nerdfonts.override {
        fonts = [
          "Iosevka"
          "IosevkaTerm"
        ];
      }
    )
  ];
}
