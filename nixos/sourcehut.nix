{ pkgs, ... }:
let
  fqdn = config.networking.hostName + optionalString (config.networking.domain != null) ".${config.networking.domain}";
in {
  networking = {
    hostName = "srht";
    domain = "tld";
    firewall.allowedTCPPorts = [ 22 80 443 ];
  };

  services.sourcehut = {
    enable = true;
    originBase = fqdn;
    services = [ "meta" "man" "git" ];
    settings = {
      "sr.ht" = {
        environment = "production";
        global-domain = fqdn;
        origin = "https://${fqdn}";
        # Produce keys with srht-keygen from sourcehut.coresrht.
        network-key = "SECRET";
        service-key = "SECRET";
      };
      webhooks.private-key= "SECRET";
    };
  };

  security.acme.certs."${fqdn}".extraDomainNames = [
    "meta.${fqdn}"
    "man.${fqdn}"
    "git.${fqdn}"
  ];

  services.nginx = {
    enable = true;
    # only recommendedProxySettings are strictly required, but the rest make sense as well.
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    # Settings to setup what certificates are used for which endpoint.
    virtualHosts = {
      "${fqdn}".enableACME = true;
      "meta.${fqdn}".useACMEHost = fqdn;
      "man.${fqdn}".useACMEHost = fqdn;
      "git.${fqdn}".useACMEHost = fqdn;
    };
  };
}