{ config, pkgs, lib, ... }:
{
  programs.helix = {
    settings = {
      editor = {
        true-color = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
          display-signature-help-docs = true;
        };
      };
    };
  };
}
