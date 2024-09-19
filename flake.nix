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
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      defaultPackage.${system} = home-manager.defaultPackage.${system};

      lib = import ./lib.nix {
        inherit pkgs;
        inherit home-manager;
      };
    };
}
