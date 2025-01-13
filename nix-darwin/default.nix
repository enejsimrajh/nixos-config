# Configuration common to all macOS systems

{ self, inputs, config, ... }:
{
  flake = {
    darwinModules = {
      my-home = {
        home-manager.backupFileExtension = "backup";
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
        inputs.agenix.darwinModules.default
        ./dock.nix
        ./finder.nix
        ./homebrew.nix
        ./screencapture.nix
      ];
    };
  };
}
