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
nix run . -- init --switch --impure
```

A basic `flake.nix` file looks like:

```nix
{
  description = "Home Manager configuration of robert";

  inputs = {
    rzbase.url = "github:zicros/dotfiles/main";
  };

  outputs = { rzbase, ... }:
    let
      system = "x86_64-linux";
      user = "robert";
      homePath = "/home/${user}";
    in {
      defaultPackage.${system} = rzbase.defaultPackage.${system};

      homeConfigurations.${user} = rzbase.lib.mkHomeConfiguration {
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        extraSpecialArgs = {
          user = user;
          homePath = homePath;
          baseDep = rzbase;
        };
      };
    };
}
```

```nix
{ config, pkgs, user, homePath, baseDep, ... }:
let
  baseDotFilesPath = "${baseDep.outPath}";
in
{
  home.username = user;
  home.homeDirectory = homePath;
  home.stateVersion = "24.05";

  imports = [
    "${baseDotFilesPath}/.config/home-manager/modules"
  ];

  # This doesn't seem to work, but leaving in here for future reference.
  # home.sessionPath = [];

  # Installs to the user profile.
  # Generally prefer distro specific packages over these for security reasons, but
  # nix can have more up-to-date packages or even more packages.
  home.packages = with pkgs; [
  ];

  rz.base = {
    enable = true;
    path = baseDotFilesPath;
    zsh.enable = true;
    tmux.enable = true;
    topydo.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
```
