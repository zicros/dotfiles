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

          # Only add to path if it's not in the path already.
          # https://unix.stackexchange.com/questions/124444/how-can-i-cleanly-add-to-path
          add_to_path() {
              case ":''${PATH:=$1}:" in
                  *:"$1":*) ;;
                  *) PATH="$1:$PATH" ;;
              esac;
          }

          add_to_path "${config.home.homeDirectory}/.local/basebin"
          add_to_path "${config.home.homeDirectory}/.local/bin"

          # added by Nix installer
          if [ -e "${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh" ]; then
            . "${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh";
          fi

          # Make sure we have the PATH populated before sourcing the real ZSHRC.
          source "${config.rz.base.path}/.zshrc"
        '';
        #source = config.lib.file.mkOutOfStoreSymlink "${config.rz.base.path}/.dotfiles/base/.zshrc";
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
