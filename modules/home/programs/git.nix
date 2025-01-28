{ pkgs, config, flake, ... }:
{
  programs.git = {
    ignores = [ "*~" ];
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "$EDITOR";
      credential.helper = "store --file ~/.git-credentials";
      pull.rebase = "true";
    };
    lfs.enable = true;
    delta = {
      enable = true;
      options = {
        features = "decorations";
        navigate = true;
        light = false;
        side-by-side = true;
      };
    };
  };
}
