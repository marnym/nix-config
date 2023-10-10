{
  description = "isofore's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    trusted-users = [ "markus" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
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
      nixosModules = import ./modules/nixos;

      nixosConfigurations = {
        koun = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./nixos/hosts/koun/configuration.nix
          ];
        };
        thinkpad = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            outputs.nixosModules.intel-undervolt
            ./nixos/hosts/thinkpad/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "markus@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs;
          modules = [
            ./home/hosts/thinkpad/home.nix
          ];
        };
        "markus@koun" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs;
          modules = [
            ./home/hosts/koun/home.nix
          ];
        };
      };
    };
}
