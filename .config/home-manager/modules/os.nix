{ config, lib, pkgs, ... }:
let cfg = config.rz.base.os;
in
{
  options.rz.base.os = with lib; {
    enable = mkEnableOption "os";
    packages_path = mkOption {
      default = null;
      type = types.nullOr types.str;
      description = ''
        Path to a file containing packages to install. Each line represent a new package.
      '';
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        home.file.".local/lib/os" = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.local/lib/os";
          recursive = true;
        };
      }

      (lib.mkIf (cfg.packages_path != null) {
        home.file.".local/lib/os/setup.d/05-install-packages.sh.env" = {
          text = ''
            PACKAGES_PATH="${cfg.packages_path}"
          '';
        };
      })
    ]
  );
}
