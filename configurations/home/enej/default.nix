{ flake, pkgs, lib, system, ... }:
let
  inherit (flake.inputs) self;
  user = flake.config.users.enej;
in
{
  imports = [
    # ./openvpn
    ./zellij
    ./alacritty.nix
    ./firefox.nix
  ];

  home = {
    stateVersion = "24.11";
    username = user.username;
    homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${user.username}";
  };

  programs = {
    alacritty.enable = true;
    direnv.enable = true;
    firefox.enable = true;
    helix = {
      enable = true;
      extraPackages = [ pkgs.marksman ];
    };
    ripgrep.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    zellij.enable = true;
    zsh = {
      enable = true;
      sessionVariables = {
        EDITOR = "hx";
      };
    };
    git = {
      enable = true;
      userName = user.fullname;
      userEmail = user.email;
    };
  };

  fonts = {
    fontlibrary = {
      nerdfonts = [
        "Iosevka"
        "IosevkaTerm"
      ];
    };
    fontconfig = {
      enable = true;
    };
  };
}
