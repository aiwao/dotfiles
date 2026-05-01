# Dotfiles
dotfiles.

reference
https://github.com/ryoppippi/dotfiles

## Setup config
```
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
git clone https://github.com/aiwao/dotfiles.git ~/ghq/github.com/aiwao/dotfiles
cd ~/ghq/github.com/aiwao/dotfiles
```

### MacOS
```sh
sudo nix run nix-darwin -- switch --flake .#aiwao
```

### Ubuntu
```sh
nix run .#switch
```

## Apply the config changes
```sh
git add .
nix run .#switch
```

## Test the config
```sh
git add .
nix run .#build
```

## Update packages
```sh
nix run .#update
```
