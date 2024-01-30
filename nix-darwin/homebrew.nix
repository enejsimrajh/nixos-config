{ flake, ... }:
{
  imports = [
    flake.inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  # Enable Homebrew
  nix-homebrew = {
    enable = true;
    user = flake.config.people.myself;
    # Declarative tap management
    taps = {
      "homebrew/homebrew-core" = flake.inputs.homebrew-core;
      "homebrew/homebrew-cask" = flake.inputs.homebrew-cask;
    };
    mutableTaps = false; # Enable fully-declarative tap management
  };

  # macOS GUI programs
  homebrew = {
    enable = true;
    casks = [
      "bitwarden"
      "discord"
      "firefox"
      "raycast"
      "slack"
      "spotify"
      "zed"
    ];
  };
}