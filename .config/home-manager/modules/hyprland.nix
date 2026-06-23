{ config, lib, pkgs, ... }:
let
  cfg = config.rz.base.hyprland;
  cfg_path = ".config/hypr";
  files_to_symlink = [
    "autostart.lua"
    "configurations.lua"
    "hyprland.lua"
    "look_and_feel.lua"
    "monitors.lua"
    "shortcuts.lua"
    "window_management.lua"
    # Hypridle
    "hypridle.conf"
    # Hyprlock
    "hyprlock.conf"

  ];
in
{
  options.rz.base.hyprland = with lib; {
    enable = mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    home.file = (builtins.listToAttrs(map (file: {
        name = "${cfg_path}/${file}";
        value = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/${cfg_path}/${file}";
        };
      }) files_to_symlink))
      // {
        "${cfg_path}/user_config.d/README.md" = {
          text = "Put your own customizations here.";
        };
      };
  };
}
