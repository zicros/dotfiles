{ config, pkgs, user, homeDirectory, base, ... }:
let
  baseDotFilesPath = "${base.outPath}";
  neovimSourcePath = "${base.inputs.rzneovim.outPath}";
in
{
  home.username = user;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.05";

  imports = [
    "${baseDotFilesPath}/.config/home-manager/modules"
  ];

  rz.base = {
    enable = true;
    path = baseDotFilesPath;
  };

  rz.neovim = {
    path = neovimSourcePath;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

# vim:ts=2:sw=2:expandtab:
