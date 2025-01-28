{
  programs.direnv = {
    nix-direnv.enable = true;
    config.global = {
      # Make direnv messages less verbose
      hide_env_diff = true;
    };
  };
}
