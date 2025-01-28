# Top-level configuration module for everything in this repo.
# Users are set in 'config.nix' in repo root.
{ flake, pkgs, lib, ... }:
let
  inherit (flake.inputs) self;
  inherit (lib) types mkOption;

  userType = types.submodule {
    options = {
      username = mkOption {
        type = types.str;
      };
      fullname = mkOption {
        type = types.str;
      };
      email = mkOption {
        type = types.str;
      };
      sshKey = mkOption {
        type = types.str;
        description = ''
          SSH public key
        '';
      };
    };
  };
in
{
  imports = [
    ../../config.nix
  ];

  options = {
    users = mkOption {
      type = types.attrsOf userType;
    };
  };
}
