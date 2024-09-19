{
  pkgs,
  home-manager
}:
let
  mkHomeConfiguration = { modules, extraSpecialArgs }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      inherit modules;
      inherit extraSpecialArgs;
    };

  lib = {
    inherit mkHomeConfiguration;
  };
in
  lib
