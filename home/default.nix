{ self, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.11";
        imports = [
          ./alacritty.nix
          ./direnv.nix
          ./firefox.nix
          ./fonts.nix
          ./git.nix
          ./ripgrep.nix
          ./starship.nix
          ./terminal.nix
          ./zellij.nix
          ./zoxide.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
          ./bash.nix
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
