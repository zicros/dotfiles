{ config, lib, pkgs, ... }:
let cfg = config.rz.base.hyprland;
in
{
  options.rz.base.hyprland = with lib; {
    enable = mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/hypr/hyprland.lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/hypr/hyprland.lua";
      };
    };
  };
}
