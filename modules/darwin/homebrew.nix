{ flake, lib, ... }:
let
  inherit (flake) inputs;
  user = "_homebrew"
in
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  users = lib.mkIf config.homebrew.enable {
    users.${user} = {};
    groups.wheel.members = [ user ];
  };

  # Enable Homebrew
  nix-homebrew = {
    enable = config.homebrew.enable;
    user = user;
    # Enable fully-declarative tap management
    mutableTaps = false;
  };
}
