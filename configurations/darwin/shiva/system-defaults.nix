{ flake, ... }:
let
  inherit (flake.config) users;
in
{
  system.defaults = {
    dock = {
      mineffect = "scale";
      minimize-to-application = true;
      show-recents = false;
      tilesize = 48;
      # Hot Corners
      wvous-tl-corner = 13; # top-left - Lock Screen
      wvous-tr-corner = 2; # top-right - Mission control
      wvous-bl-corner = 3; # bottom-left - Application Windows
      wvous-br-corner = 14; # bottom-right - Quick note
      persistent-apps = [
        "/Applications/Safari.app"
        "/Applications/Firefox.app"
        "/Users/${users.enej.username}/Applications/Home Manager Apps/Alacritty.app"
        "/Applications/Zed.app"
        "/Applications/Sublime Merge.app"
        "/System/Applications/Notes.app"
        "/System/Applications/Mail.app"
        "/Applications/Spotify.app"
      ];
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
    };
    screencapture = {
      location = "~/Pictures/Screenshots";
    };
  };
}
