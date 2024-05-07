{ pkgs, config, lib, ... }:
let
  fqdn = config.networking.hostName + lib.optionalString (config.networking.domain != null) ".${config.networking.domain}";
in {
  services.cgit."git.${fqdn}" = {
    enable = true;
    nginx.location = "/cgit/";
    scanPath = "/var/lib/git";
    settings = {
      enable-follow-links = true;
      source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";
    };
  };

  environment.systemPackages = [ pkgs.git ];
}
