# See nix-darwin/default.nix for other modules in use.

{ pkgs, flake, ... }:
{
  # macOS GUI programs
  homebrew = {
    enable = true;
    casks = [
      "bitwarden"
      "firefox"
      "raycast"
      "discord"
      "slack"
      "spotify"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  # For home-manager to work.
  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    home = "/Users/${flake.config.people.myself}";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}