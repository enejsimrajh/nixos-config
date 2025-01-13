{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "hx";
    };
    initExtra = ''
      export PATH=/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin/:/nix/var/nix/profiles/system/sw/bin:/usr/local/bin:$PATH
    '';
  };
}
