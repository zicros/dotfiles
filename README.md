# Bootstrap OS

## Windows
```powershell
Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest https://raw.githubusercontent.com/zicros/dotfiles/refs/heads/main/.local/lib/bootstrap/setup.ps1).Content))
```

# Setup
Generally speaking, to bootstrap:

1. Setting up the alias and environment variables
For Linux:

```bash
DOTFILES_PATH=$HOME/git/dotfiles
mkdir -p "$DOTFILES_PATH"
alias config='/usr/bin/git --git-dir=$DOTFILES_PATH --work-tree=$HOME'
```

For Windows:

```powershell
$DOTFILES_PATH = Join-Path $HOME "git/dotfiles"
$null = mkdir -Force "$DOTFILES_PATH"
function config() { git --git-dir="$DOTFILES_PATH" --work-tree=$HOME @args }
```
2. Clone the repo and restore the files

```bash
git clone --bare <REPO> "$DOTFILES_PATH"
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
  --extra-experimental-features "nix-command flakes" \
  run $HOME/.config/home-manager -- \
  --extra-experimental-features "nix-command flakes" \
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

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      user = "robert";

      mkHomeConfig = { pkgs }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
            inherit user;
          };

          modules = [ ./home.nix ];
        };

    in {
      packages = {
        aarch64-linux.homeConfigurations.${user} = mkHomeConfig {
            default = home-manager.packages.aarch64-linux.default;
            pkgs = nixpkgs.legacyPackages.aarch64-linux;
        };
        x86_64-linux = {
            default = home-manager.packages.x86_64-linux.default;
            homeConfigurations.${user} = mkHomeConfig {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
            };
        };
      };
    };
}
```

`home.nix`

```nix
{ inputs, user, config, pkgs, ... }:
let
  baseDotFilesPath = inputs.rzbase.outPath;
in
{
  imports = [
    "${baseDotFilesPath}/.config/home-manager/modules"
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # Installs to the user profile.
  # Generally prefer distro specific packages over these for security reasons, but
  # nix can have more up-to-date packages or even more packages.
  home.packages = with pkgs; [
  ];

  rz.base = {
    enable = true;
    zsh.enable = true;
    tmux.enable = true;
  };

  rz.neovim = {
    enable = true;
  };
}

# vim:ts=2:sw=2:expandtab:
```
