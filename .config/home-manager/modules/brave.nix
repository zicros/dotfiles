{ config, lib, pkgs, ... }:
let
  base_path = config.rz.base.path;
  cfg = config.rz.base.brave;
in
{
  options.rz.base.brave = with lib; {
    enable = mkEnableOption "brave";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/brave-flags.conf" = {
          source = config.lib.file.mkOutOfStoreSymlink "${base_path}/.config/brave-flags.conf";
      };
    };
  };
}
