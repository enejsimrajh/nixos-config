{ flake, config, ... }:
let
  inherit (flake.inputs) self;

  relativePath = "Library/Application Support/OpenVPN Connect/profiles";
  absolutePath = "${config.home.homeDirectory}/${relativePath}";
in
{
  age.secrets = {
    openvpn-platform-private-key = {
      file = self + /secrets/platform/openvpn-private.key.age;
      path = "${absolutePath}/platform-private.key";
    };
    openvpn-platform-static-key = {
      file = self + /secrets/platform/openvpn-static.key.age;
      path = "${absolutePath}/platform-static.key";
    };
  };

  home.file = {
    openvpn-platform-ca = {
      target = "${relativePath}/platform-ca.crt";
      source = ./openvpn-ca.crt;
    };
    openvpn-platform-cert = {
      target = "${relativePath}/platform-cert.crt";
      source = ./openvpn-cert.crt;
    };
    openvpn-platform-config = {
      target = "${relativePath}/platform-config.ovpn";
      text = ''
        client
        dev tun
        remote 84.255.204.104 1199 udp
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        verb 3
        cipher AES-256-CBC
        remote-cert-tls server
        ca platform-ca.crt
        cert platform-cert.crt
        key platform-private.key
        tls-crypt platform-static.key
      '';
    };
  };
}
