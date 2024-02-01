{
  programs.zsh = {
    enable = true;
    initExtra = ''
        export PATH=/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin/:$PATH
    '';
  };
}
