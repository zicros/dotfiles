{ config, lib, ... }:
let cfg = config.rz.base;
in
{
  options.rz.base = with lib; {
    enable = mkEnableOption "base";
    path = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "$HOME/.dotfiles/base";
      description = ''
        The path to the base dotfiles.
      '';
    };
  };
}
