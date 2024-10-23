# Initially generated with `nix run home-manager/master -- init --switch`
{
  description = "Home Manager configuration of robert";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rzneovim = {
        url = "git+ssh://git@github.com/zicros/nvim";
        flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      defaultPackage.aarch64-linux = home-manager.defaultPackage.aarch64-linux;

      lib = import ./.config/home-manager/lib.nix {
        inherit pkgs;
        inherit self;
      };
    };
}
