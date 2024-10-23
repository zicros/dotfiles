# Initially generated with `nix run home-manager/master -- init --switch`
{
  description = "Home Manager configuration of robert";

  inputs = {
    # Caller specifies the nixpkgs to use so they can provide the right packages matching architecture.
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
