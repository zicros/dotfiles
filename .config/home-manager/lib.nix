{
  self
}:
let
in
{
  packages = { pkgs }:
    import ./modules/packages { inherit pkgs; };
}

# vim:ts=2:sw=2:expandtab:
