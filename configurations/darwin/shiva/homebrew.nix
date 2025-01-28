{ flake, ... }:
let
  inherit (flake) inputs;
in
{
  nix-homebrew.taps = {
    "homebrew/homebrew-core" = inputs.homebrew-core;
    "homebrew/homebrew-cask" = inputs.homebrew-cask;
    "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
  };

  homebrew = {
    casks = [
      "discord"
      "firefox"
      "openvpn-connect"
      "spotify"
      "sublime-merge"
      "swish"
      "zed"
    ];
    # Search for app IDs using the mas CLI app
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    masApps = {
      "adguard" = 1440147259;
      "bitwarden" = 1352778147;
    };
  };
}
