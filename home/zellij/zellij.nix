{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile.zellij = {
    source = ./dotfiles;
    recursive = true;
  };
}
