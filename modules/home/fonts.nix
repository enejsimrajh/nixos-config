{ pkgs, lib, ... }:
let
  cfg = config.fonts.fontlibrary;
in
{
  options.fonts.fontlibrary = {
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = null;
      example = "[ pkgs.fira-code ]";
    };
    nerdfonts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = null;
      example = "[ \"Iosevka\" \"IosevkaTerm\" ]";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.packages != null) {
      home.packages = cfg.packages
    })
    (lib.mkIf (cfg.nerdfonts != null) {
      home.packages = pkgs.nerdfonts.override {
        fonts = nerdfonts;
      }
    })
  ];
}
