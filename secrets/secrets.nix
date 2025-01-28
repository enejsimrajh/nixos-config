let
  config = import ../config.nix;
  users = config.users;
in
{
  "platform/openvpn-private.key.age".publicKeys = [ users.enej.sshKey ];
  "platform/openvpn-static.key.age".publicKeys = [ users.enej.sshKey ];
}
