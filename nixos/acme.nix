{ pkgs, ... }:
let
  fqdn = config.networking.hostName + optionalString (config.networking.domain != null) ".${config.networking.domain}";
in {
  security.acme = {
    acceptTerms = true;
    defaults.email = "enej.simrajh@icloud.com";
    certs."${fqdn}".extraDomainNames = [
      "meta.${fqdn}"
      "man.${fqdn}"
      "git.${fqdn}"
    ];
  };
}