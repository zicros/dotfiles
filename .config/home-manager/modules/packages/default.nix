{ config, pkgs, lib, ... }:
{
    nixpkgs.overlays = [
        (final: prev: {
            rz_fzf = pkgs.callPackage ./fzf { };
        })
    ];
}
