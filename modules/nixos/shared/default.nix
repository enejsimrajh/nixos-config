{ lib, ... }:
let
  inherit (lib) filter filesystem hasSuffix;
  inherit (filesystem) listFilesRecursive;

  importDir = dir: filter
    (filename: hasSuffix ".nix" filename && !(hasSuffix "default.nix" filename))
    (listFilesRecursive dir);
in
{
  imports = importDir ./.;
}
