{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.11";
        imports = [
          inputs.agenix.homeManagerModules.default
          ./alacritty.nix
          ./direnv.nix
          ./firefox.nix
          ./fonts.nix
          ./git.nix
          ./helix.nix
          ./openvpn/openvpn.nix
          ./ripgrep.nix
          ./ssh.nix
          ./starship.nix
          ./terminal.nix
          ./yazi/yazi.nix
          ./zellij/zellij.nix
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
