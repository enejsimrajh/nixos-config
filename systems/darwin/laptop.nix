{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
    "${self}/nix-darwin/linux-builder.nix"
  ];

  environment.systemPackages = with pkgs; [
    dotnetCorePackages.sdk_6_0
    omnisharp-roslyn
  ];

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.2/24" "fdc9:281f:04d7:9ee9::2/64" ];
      dns = [ "10.0.0.1" "fdc9:281f:04d7:9ee9::1" ];
      privateKeyFile = "~/wireguard-keys/shiva/private";

      peers = [
        {
          publicKey = "wryV4qCuKlEzzgMpVQV6fT2GT3mXSSUIh+e6jnPfcmU=";
          presharedKeyFile = "~/wireguard-keys/shiva/psk";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "10.0.0.1:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # For home-manager to work.
  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    home = "/Users/${flake.config.people.myself}";
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
