{ self, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.11";
        imports = [
          ./alacritty.nix
          ./bash.nix
          ./direnv.nix
          ./firefox.nix
          ./git.nix
          ./ripgrep.nix
          ./starship.nix
          ./terminal.nix
          ./zoxide.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
          ./hyprland.nix
        ];
      };
      common-darwin = {
        imports = [
          self.homeModules.common
          ./zsh.nix
        ];
      };
    };
  };
}
