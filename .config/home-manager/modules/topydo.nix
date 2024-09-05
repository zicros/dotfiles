{ config, lib, pkgs, ... }:
let cfg = config.rz.base.topydo;
in
{
  options.rz.base.topydo = with lib; {
    enable = mkEnableOption "topydo";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/topydo/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/topydo/config";
      };
    };
  };
}
