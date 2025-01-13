{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile.yazi = {
    source = ./dotfiles;
    recursive = true;
  };

  home.packages = [
    (pkgs.writeShellApplication {
      name = "ide-open-file";
      runtimeInputs = [ pkgs.zellij ];
      text = builtins.readFile ./ide-open-file.sh;
    })
  ];
}
