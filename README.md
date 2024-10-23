# Setup
Generally speaking, to bootstrap:

1. Setting up the alias and environment variables
For Linux:

```bash
DOTFILES_PATH=$HOME/.dotfiles
mkdir -p "$DOTFILES_PATH"
alias config='/usr/bin/git --git-dir=$DOTFILES_PATH/personal --work-tree=$HOME'
```

For Windows:

```powershell
$DOTFILES_PATH = Join-Path $HOME ".dotfiles"
$null = mkdir -Force "$DOTFILES_PATH"
function config() { git --git-dir="$DOTFILES_PATH/personal" --work-tree=$HOME @args }
```
2. Clone the repo and restore the files

```bash
git clone --bare <REPO> "$DOTFILES_PATH/personal"
config config status.showUntrackedFiles no
config restore --staged $HOME && config restore $HOME
```
3. LINUX ONLY: To get everything fully working, you'll need to setup up all the symlinks and paths:

```bash
# Install NIX for single user setup
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Install home-manager and switch
# There may be some errors, but it should switch.
nix \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  run $HOME/.config/home-manager -- \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  init \
  switch
```

Future runs can just be:

```
nix run $HOME/.config/home-manager -- switch
```

A basic `flake.nix` file looks like:

```nix
{
  description = "Home Manager configuration of robert";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rzbase = {
        url = "github:zicros/dotfiles/main";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, rzbase, ... }:
    let
      user = "robert";
      homeDirectory = "/home/${user}";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      defaultPackage.x86_64-linux = rzbase.defaultPackage.x86_64-linux;
      defaultPackage.aarch64-linux = rzbase.defaultPackage.aarch64-linux;

      homeConfigurations.${user} = rzbase.lib.mkHomeConfiguration {
        inherit pkgs;
        inherit user;
        inherit homeDirectory;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
      };
    };
}
```

`home.nix`

```nix
{ config, pkgs, ... }:
let
in
{
  # Installs to the user profile.
  # Generally prefer distro specific packages over these for security reasons, but
  # nix can have more up-to-date packages or even more packages.
  home.packages = with pkgs; [
  ];

  rz.base = {
    zsh.enable = true;
    tmux.enable = true;
    topydo.enable = true;
  };

  rz.neovim = {
    enable = true;
  };
}

# vim:ts=2:sw=2:expandtab:
```
