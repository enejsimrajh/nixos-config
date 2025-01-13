let
  config = import ../users/config.nix;
  myself = config.users.enejsimrajh.sshKey;
in
{
  "platform/openvpn-private.key.age".publicKeys = [ myself ];
  "platform/openvpn-static.key.age".publicKeys = [ myself ];
}
