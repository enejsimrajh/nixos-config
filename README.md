# nixos-config

This repository contains the NixOS configuration for my systems. This is still work in progress and I will most likely make a lot changes as I use this configuration. I also plan to switch from using WSL to dual booting Windows and NixOS on my desktop PC.

## Setup

To use this configuration for a machine running:

### macOS
- Install nix
  ```zsh
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```
- Start a nix-shell to make git available
  ```zsh
  nix-shell -p git
  ```
- Clone this repository
  ```zsh
  git clone https://github.com/enejsimrajh/nixos-config.git
  ```
- Activate nixos configuration
    ```zsh
  cd nixos-config && nix run
  ```
