{ pkgs, config, lib, ... }:
let
  fqdn = config.networking.hostName + lib.optionalString (config.networking.domain != null) ".${config.networking.domain}";
in
{
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    # virtualHosts = {
    #   "test.${fqdn}" = {
    #     default = true;
    #     locations."/" = {
    #       root = pkgs.writeTextDir "index.html" "Hello world!";
    #     };
    #   };
    # };
  };
}
