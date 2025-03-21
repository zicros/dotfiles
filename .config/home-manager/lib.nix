{
  self,
  pkgs
}:
let
  customPackages = import ./modules/packages { inherit pkgs; };
in
{
  packages = customPackages;
}

# vim:ts=2:sw=2:expandtab:
