{ config, lib, pkgs, ... }:
let cfg = config.rz.base.sway;
in
{
  options.rz.base.sway = with lib; {
    enable = mkEnableOption "sway";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/sway/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/sway/config";
      };
      ".config/sway/config.d" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/sway/config.d";
        recursive = true;
      };
    };
  };
}
