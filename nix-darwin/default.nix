  # Configuration common to all macOS systems

{ self, config, ... }:
{
  flake = {
    darwinModules = {
      my-home = {
        home-manager.users.${config.people.myself} = { pkgs, ... }: {
          imports = [
            self.homeModules.common-darwin
          ];
        };
      };

      default.imports = [
        self.darwinModules_.home-manager
        self.darwinModules.my-home
        self.nixosModules.common
        ./homebrew.nix
      ];
    };
  };
}
