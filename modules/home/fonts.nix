{ pkgs, lib, config, ... }:
let
  cfg = config.fonts.fontlibrary;
in
{
  options.fonts.fontlibrary = {
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      example = "[ pkgs.fira-code ]";
    };
    nerdfonts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = "[ \"Iosevka\" \"IosevkaTerm\" ]";
    };
  };

  config = {
    home.packages = [
      (
        pkgs.nerdfonts.override {
          fonts = cfg.nerdfonts;
        }
      )
    ] ++ cfg.packages;
  };
}
