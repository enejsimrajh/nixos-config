{ pkgs, config, lib, ... }:
let
  fqdn = config.networking.hostName + lib.optionalString (config.networking.domain != null) ".${config.networking.domain}";
in {
  security.acme = {
    acceptTerms = true;
    defaults.email = "enej.simrajh@icloud.com";
  };
}
