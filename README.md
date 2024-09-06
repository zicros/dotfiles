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
nix run home-manager/master --extra-experimental-features "nix-command flakes" -- init --switch
--impure
```
