# Configuration for virtual machines running under QEMU

{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  networking.hostName = "maya";

  # # Configure networking
  # networking = {
  #   hostName = "maya";
  #   useDHCP = false;
  #   interfaces.eth0.useDHCP = true;

  #   # Wireguard and dnsmasq config
  #   nat = {
  #     enable = true;
  #     enableIPv6 = true;
  #     externalInterface = "eth0";
  #     internalInterfaces = [ "wg0" ];
  #   };
  #   firewall = {
  #     allowedTCPPorts = [ 53 ];
  #     allowedUDPPorts = [ 53 51820 ];
  #   };
  #   wg-quick.interfaces = {
  #     # "wg0" is the network interface name. You can name the interface arbitrarily.
  #     wg0 = {
  #       # Determines the IP/IPv6 address and subnet of the client's end of the tunnel interface
  #       address = [ "10.0.0.1/24" "fdc9:281f:04d7:9ee9::1/64" ];
  #       # The port that WireGuard listens to - recommended that this be changed from default
  #       listenPort = 51820;
  #       # Path to the server's private key
  #       privateKeyFile = "~/wireguard-keys/maya/private";

  #       # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
  #       postUp = ''
  #         ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
  #         ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
  #         ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
  #         ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
  #       '';

  #       # Undo the above
  #       preDown = ''
  #         ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
  #         ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
  #         ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
  #         ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
  #       '';

  #       peers = [
  #         {
  #           # shiva
  #           publicKey = "HP6/1cu84xq7UlQRWZA1YNQmfRtDDm0xNAJxeAzY6AE=";
  #           presharedKeyFile = "~/wireguard-keys/shiva/psk";
  #           allowedIPs = [ "10.0.0.2/32" "fdc9:281f:04d7:9ee9::2/128" ];
  #         }
  #         # More peers can be added here.
  #       ];
  #     };
  #   };
  # };

  # services.dnsmasq = {
  #   enable = true;
  #   extraConfig = ''
  #     interface=wg0
  #   '';
  # };

  # virtualisation = {
  #   vmVariant.virtualisation = {
  #     graphics = false;
  #     forwardPorts = [
  #       {
  #         from = "host";
  #         host.port = 8080;
  #         guest.port = 80;
  #       }
  #     ];
  #   };
  # };

  # users.users.${flake.config.people.myself} = {
  #   name = flake.config.people.myself;
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ];
  # };

  # services.getty.autologinUser = flake.config.people.myself;
  # security.sudo.wheelNeedsPassword = false;

  # system.stateVersion = "23.11";
}
