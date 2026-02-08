# Dotfiles
dotfiles.

reference
https://github.com/ryoppippi/dotfiles

## Setup config
```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
git clone https://github.com/aiwao/dotfiles.git ~/ghq/github.com/aiwao/dotfiles
cd ~/ghq/github.com/aiwao/dotfiles
sudo nix run nix-darwin -- switch --flake .#aa
```

## Apply config changes
```sh
git add .
nix run .#switch
```

## Test config (not apply)
```sh
git add .
nix run .#build
```

## Update packages
```sh
nix run .#update
```
