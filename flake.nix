{
  description = "isofore's NixOS Flake";

  nixConfig = {
    experimental-features = "nix-command flakes";
    substituters = "https://cache.nixos.org";
    extra-substituters = "https://hydra.nixos.org https://nix-community.cachix.org https://hyprland.cachix.org";
    extra-trusted-public-keys = ''
      cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=
    '';
    auto-optimize-store = true;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland/v0.30.0";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs outputs;
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      packages.x86_64-linux = import ./pkgs nixpkgs.legacyPackages.x86_64-linux;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosModules = import ./modules;

      nixosConfigurations = {
        koun = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./nixos/configuration/koun.nix
          ];
        };
        thinkpad = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./nixos/configuration/thinkpad.nix
          ];
        };
      };

      homeConfigurations = {
        "markus@koun" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs;
          modules = [
            ./home/koun.nix
          ];
        };
        "markus@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs;
          modules = [
            ./home/thinkpad.nix
          ];
        };
      };
    };
}
