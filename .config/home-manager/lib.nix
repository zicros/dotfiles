{
  self
}:
let
  mkHomeConfiguration = { modules, user, homeDirectory }:
    let
      base = self;
    in
      base.inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit user;
          inherit homeDirectory;
          inherit base;
        };

        modules = [ ./base.nix ] ++ modules;
      };

  lib = {
    inherit mkHomeConfiguration;
  };
in
  lib

# vim:ts=2:sw=2:expandtab:
