{ config, lib, pkgs, ... }:
let cfg = config.rz.base.tmux;
in
{
  options.rz.base.tmux = with lib; {
    enable = mkEnableOption "tmux";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".tmux.conf" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.tmux.conf";
      };
      ".config/tmux/config.d" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/tmux/config.d/";
        recursive = true;
      };
    };
  };
}
