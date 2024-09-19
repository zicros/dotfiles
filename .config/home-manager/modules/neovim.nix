{ config, lib, pkgs, ... }:
let
  cfg = config.rz.neovim;
in
{
  options.rz.neovim = with lib; {
    enable = mkEnableOption "neovim";
    path = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        The path to the neovim config directory.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink config.rz.neovim.path;
      };
    };
  };
}

# vim:ts=2:sw=2:expandtab:
