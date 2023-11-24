{
  description = "isofore's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    builders-use-substitutes = true;
    substituters = [
      "https://cache.nixos.org"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    extra-trusted-public-keys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland/v0.30.0";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      inherit (self) outputs;

      x64_system = "x86_64-linux";
      aarch_darwin = "aarch64-darwin";
      x64_darwin = "x86_64-darwin";
      systems = [ x64_system aarch_darwin x64_darwin ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      specialArgs = system:
        let
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          inherit inputs outputs;
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              packageOverrides = pkgs: {
                unstable = pkgs-unstable;
                hyprland-flake = inputs.hyprland.packages.${pkgs.system}.hyprland;
                hyprshot = outputs.packages.${pkgs.system}.hyprshot;
                intel-undervolt = outputs.packages.${pkgs.system}.intel-undervolt;
              };
            };
          };
        };

      nixFrozen = {
        # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
        nix.registry.nixpkgs.flake = nixpkgs;

        # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
        environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
        nix.nixPath = [ "/etc/nix/inputs" ];
      };
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      nixosConfigurations =
        let
          system = x64_system;
        in
        {
          timred = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs system;
            modules = [ ./hosts/timred nixFrozen ];
          };
          thinkpad = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs system;
            modules = [ ./hosts/thinkpad nixFrozen ];
          };
          pers-h = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs system;
            modules = [ ./hosts/pers-h nixFrozen ];
          };
        };

      homeConfigurations = {
        "markus@timred" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs x64_system;
          modules = [ ./home/timred.nix ];
        };
        "markus@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs x64_system;
          modules = [ ./home/thinkpad.nix ];
        };
        "markusnyman@MacFrier-Pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          extraSpecialArgs = specialArgs x64_darwin;
          modules = [ ./home/frier.nix ];
        };
        "markus@WorkBook-Pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = specialArgs aarch_darwin;
          modules = [ ./home/work.nix ];
        };
      };
    };
}
