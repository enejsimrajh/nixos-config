{ flake, ... }:
{
  system.defaults.dock = {
    mineffect = "scale";
    minimize-to-application = true;
    persistent-apps = [
      "/Applications/Safari.app"
      "/Applications/Firefox.app"
      "/Users/${flake.config.people.myself}/Applications/Home Manager Apps/Alacritty.app"
      "/Applications/Zed.app"
      "/Applications/Sublime Merge.app"
      "/System/Applications/Notes.app"
      "/System/Applications/Mail.app"
      "/Applications/Spotify.app"
    ];
    show-recents = false;
    tilesize = 48;
  };
}
