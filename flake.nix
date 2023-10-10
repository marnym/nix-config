{
  description = "isofore's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://hyprland.cachix.org"
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
    in
    {
      packages.x86_64-linux = import ./pkgs nixpkgs.legacyPackages.x86_64-linux;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosModules = import ./modules/nixos;

      nixosConfigurations =
        let
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
          thinkpad = nixpkgs.lib.nixosSystem {
            inherit system specialArgs;
            modules = [
              ./hosts/thinkpad/configuration.nix
              outputs.nixosModules.intel-undervolt
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.markus = import ./hosts/thinkpad/home.nix;
              }
            ];
          };

          koun = nixpkgs.lib.nixosSystem {
            inherit system specialArgs;
            modules = [
              ./hosts/koun/configuration.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.markus = import ./hosts/koun/home.nix;
              }
            ];
          };
        };
    };
}
