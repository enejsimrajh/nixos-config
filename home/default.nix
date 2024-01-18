{ self, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.11";
        imports = [
          ./bash.nix
          ./carapace.nix
          ./direnv.nix
          ./git.nix
          ./helix.nix
          ./just.nix
          ./nushell.nix
          ./starship.nix
          ./terminal.nix
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
        ];
      };
    };
  };
}