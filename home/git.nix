{ pkgs, config, flake, ... }:
{
  programs.git = {
    enable = true;
    userName = flake.config.people.users.${config.home.username}.name;
    userEmail = flake.config.people.users.${config.home.username}.email;
    ignores = [ "*~" ];
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "code --wait";
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