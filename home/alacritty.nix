{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "IosevkaTerm Nerd Font";
          style = "Regular";
        };
        size = 16;
      };
      window = {
       option_as_alt = "OnlyLeft";
      };
    };
  };
}
