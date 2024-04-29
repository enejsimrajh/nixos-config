{ pkgs, ... }:
let
  fqdn = config.networking.hostName + optionalString (config.networking.domain != null) ".${config.networking.domain}";
in {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    # Configure what certificates are used for which endpoint.
    virtualHosts = {
      "${fqdn}".enableACME = true;
      "meta.${fqdn}".useACMEHost = fqdn;
      "man.${fqdn}".useACMEHost = fqdn;
      "git.${fqdn}".useACMEHost = fqdn;
    };
  };
}