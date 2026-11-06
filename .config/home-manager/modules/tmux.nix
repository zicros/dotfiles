{ config, lib, pkgs, ... }:
let cfg = config.rz.base.tmux;
in
{
  options.rz.base.tmux = with lib; {
    enable = mkEnableOption "tmux";
    service = {
      enable = mkEnableOption "tmux service";
      session_name = mkOption {
        type = types.str;
        default = "dev" ;
        description = ''
          Session name to use in the service
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.file = {
        ".tmux.conf" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.tmux.conf";
        };
        ".config/tmux/config.d" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/tmux/config.d/";
            recursive = true;
        };
      };
    }

    # TMUX service
    (
      lib.mkIf cfg.service.enable {
        home.file = {
          ".config/systemd/user/tmux@.service" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/systemd/user/tmux@.service";
          };
        };
      }
    )
  ]);
}
