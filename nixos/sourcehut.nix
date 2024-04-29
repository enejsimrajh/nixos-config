{ pkgs, ... }:
let
  fqdn = config.networking.hostName + optionalString (config.networking.domain != null) ".${config.networking.domain}";
in {
  services.sourcehut = {
    # Enable Sourcehut services
    enable = true;
    git.enable = true;
    man.enable = true;
    meta.enable = true;
    # Integrate Sourcehut into locally running services
    nginx.enable = true;
    postfix.enable = true;
    postgresql.enable = true;
    redis.enable = true;
    # Configure Sourcehut settings
    settings = {
      "sr.ht" = {
        environment = "production";
        global-domain = fqdn;
        origin = "https://${fqdn}";
        # Produce keys with srht-keygen from sourcehut.coresrht.
        network-key = "/run/keys/path/to/network-key";
        service-key = "/run/keys/path/to/service-key";
      };
      webhooks.private-key= "/run/keys/path/to/webhook-key";
    };
  };
}