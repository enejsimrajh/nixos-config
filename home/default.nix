{ self, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.11";
        imports = [
          ./bash.nix
          ./direnv.nix
          ./gh.nix
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
