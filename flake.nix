{
  description = "Enej's NixOS/nix-darwin configuration";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Software
    nuenv.url = "github:DeterminateSystems/nuenv";
    nixd.url = "github:nix-community/nixd";

    # Homebrew taps
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    # Devshell
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "aarch64-linux" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.nixos-flake.flakeModule
        ./users
        ./home
        ./nixos
        ./nix-darwin
      ];

      flake = {
        # Configurations for Linux (NixOS) machines
        nixosConfigurations = {
          # Personal desktop
          "brahma" = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              ./systems/desktop.nix
            ];
          };

          # Home server
          "vishnu" = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              ./systems/nixos/server.nix
            ];
          };

          # NixOS VM for macOS machines
          "maya" = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "aarch64-linux";
            imports = [
              ./systems/nixos/qemu.nix
              {
                virtualisation.vmVariant.virtualisation.host.pkgs = nixpkgs.legacyPackages.aarch64-darwin;
              }
            ];
          };

          # NixOS VM for Windows machines
          "yama" = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              ./systems/nixos/wsl.nix
            ];
          };
        };

        # Configurations for macOS machines
        darwinConfigurations = {
          # Personal laptop
          "shiva" = self.nixos-flake.lib.mkMacosSystem {
            nixpkgs.hostPlatform = "aarch64-darwin";
            imports = [
              ./systems/darwin/laptop.nix
            ];
          };
        };

        packages.aarch64-darwin.darwin-vm = self.nixosConfigurations.maya.config.system.build.vm;
      };

      perSystem = { self', system, pkgs, lib, config, inputs', ... }: {
        nixos-flake.primary-inputs = [ "nixpkgs" "home-manager" "nix-darwin" "nixos-flake" ];

        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.nixpkgs-fmt.enable = true;
        };

        packages.default = self'.packages.activate;

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nixpkgs-fmt
            pkgs.sops
            pkgs.ssh-to-age
          ];
        };

        formatter = config.treefmt.build.wrapper;
      };
    };
}
