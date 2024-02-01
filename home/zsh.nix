{
  programs.zsh = {
    enable = true;
    envExtra = ''
        export PATH=/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin/:$PATH
    '';
  };
}
