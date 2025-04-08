{ config, lib, pkgs, ... }:
let cfg = config.rz.base.zsh;
in
{
  options.rz.base.zsh = with lib; {
    enable = mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".zshrc" = {
        text = ''
          # This is a generated file. DO NOT MODIFY.

          # added by Nix installer
          if [ -e "${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh" ]; then
            . "${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh";
          fi

          source "${config.rz.base.path}/.zshrc"
        '';
      };
      ".config/zsh/.zshrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/zsh/.zshrc";
      };
      ".config/zsh/init" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/zsh/init";
      };
      ".config/zsh/themes" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.config/zsh/themes";
      };
    };
  };
}
