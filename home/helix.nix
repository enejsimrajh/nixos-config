{ config, pkgs, lib, ... }:
{
  options = {
    my.helix = {
      markdown.enable = lib.mkEnableOption "Enable markdown support" // { default = true; };
    };
  };

  config.programs.helix = {
    enable = true;
    extraPackages = lib.optional config.my.helix.markdown.enable pkgs.marksman;
    settings = {
      editor = {
        true-color = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
          display-signature-help-docs = true;
        };
      };
      keys = {};
    };
  };
}
