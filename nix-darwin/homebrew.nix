{ flake, ... }:
{
  imports = [
    flake.inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  # Enable Homebrew
  nix-homebrew = {
    enable = true;
    user = flake.config.people.myself;
    # Enable fully-declarative tap management
    mutableTaps = false;
    taps = {
      "homebrew/homebrew-core" = flake.inputs.homebrew-core;
      "homebrew/homebrew-cask" = flake.inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = flake.inputs.homebrew-bundle;
    };
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
      "warp"
      "zed"
    ];
  };
}
