{
  description = "isofore's NixOS Flake";

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
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      specialArgs = {
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
      packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;

      nixosConfigurations = {
        koun = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/koun/configuration.nix
            nixFrozen
          ];
        };
        thinkpad = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/thinkpad/configuration.nix
            nixFrozen
          ];
        };
      };

      homeConfigurations = {
        "markus@koun" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs;
          modules = [ ./home/koun.nix ];
        };
        "markus@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs;
          modules = [ ./home/thinkpad.nix ];
        };
      };
    };
}
