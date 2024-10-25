{ config, lib, pkgs, ... }:
let cfg = config.rz.base.topydo;
in
{
  options.rz.base.swappy = with lib; {
    enable = mkEnableOption "swappy";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/swappy/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/swappy/config";
      };
    };
  };
}
