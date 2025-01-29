{ flake, lib, config, ... }:
let
  inherit (flake) inputs;
  serviceUser = "_nix-homebrew";
in
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  users = lib.mkIf config.homebrew.enable {
    users.${serviceUser} = {
      createHome = false;
      description = "Homebrew service user";
      uid = lib.mkDefault 499;
    };
    knownUsers = [ serviceUser ];
    groups.wheel.members = [ serviceUser ];
  };

  # Enable Homebrew
  nix-homebrew = lib.mkIf config.homebrew.enable {
    enable = true;
    user = serviceUser;
    # Enable fully-declarative tap management
    mutableTaps = false;
  };
}
