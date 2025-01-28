{
  imports = {
    ./programs
    ./fonts.nix
  }

  backupFileExtension = "nixos-config-backup";
  nix.gc.automatic = true;
}
