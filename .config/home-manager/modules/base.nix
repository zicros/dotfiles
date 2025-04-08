{ config, lib, pkgs, inputs, ... }:
let
  basePath = inputs.rzbase.outPath;
  cfg = config.rz.base;
in
{
  options.rz.base = with lib; {
    enable = mkEnableOption "base";
    path = mkOption {
      type = types.str;
      default = basePath ;
      example = "$HOME/.dotfiles/base";
      description = ''
        The path to the base dotfiles.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/nix/nix.conf" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/nix/nix.conf";
      };
      ".local/lib/bin.d/base" = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.local/bin";
      };
    };
  };
}

# vim:ts=2:sw=2:expandtab:
