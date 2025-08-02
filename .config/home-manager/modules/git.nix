{ config, lib, pkgs, ... }:
let
  cfg = config.rz.base.git;
  git_config_path = ".config/git";
in
{
  options.rz.base.git = with lib; {
    enable = mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      "${git_config_path}/gitconfig" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/git/gitconfig";
      };
      "${git_config_path}/config.d" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/git/config.d/";
        recursive = true;
      };
    };
  };
}
