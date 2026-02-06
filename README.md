# Dotfiles
dotfiles.

## Apply config
```sh
sudo nix run nix-darwin --switch --flake .#aa
```

## Update config and apply
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
