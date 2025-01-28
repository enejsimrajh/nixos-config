{ lib, ... }:
let
  inherit (lib) filter filesystem.listFilesRecursive;

  let importDir = dir: filter
    (filename: filename != "default.nix")
    (listFilesRecursive dir);
in
{
  imports = importDir ./.
}
