{
  description = "Personal NixOS flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://ghostty.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?tag=v0.41.1&submodules=1";

    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";

    waybar-spotify = {
      url = "github:marnym/waybar-spotify";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homework-template = {
      url = "git+ssh://git@github.com/marnym/homework-template";
      flake = false;
    };

    ranger-devicons = {
      url = "github:alexanderjeurissen/ranger_devicons/ed718dd6a6d5d2c0f53cba8474c5ad96185057e9";
      flake = false;
    };

    private.url = "git+ssh://git@github.com/marnym/nix-private";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      inherit (self) outputs;

      x64_linux = "x86_64-linux";
      aarch_linux = "aarch64-linux";
      aarch_darwin = "aarch64-darwin";
      x64_darwin = "x86_64-darwin";
      systems = [ x64_linux aarch_darwin x64_darwin ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs { inherit system overlays; };
      });


      overlays = [
        (self: super:
          let
            version = "v7.0-beta20";
          in
          {
            maple-mono-otf = super.maple-mono-otf.overrideAttrs { inherit version; };
            maple-mono-NF = super.maple-mono-NF.overrideAttrs { inherit version; };
          })
      ];

      specialArgs = system: {
        inherit inputs;

        pkgs = import nixpkgs {
          inherit system overlays;
          config = {
            allowUnfree = true;
          };
        };

        pkgs-unstable = import nixpkgs-unstable {
          inherit system overlays;
          config.allowUnfree = true;
        };
      };

      moduleArgs = system: packages: {
        inherit (inputs) private;

        hyprland = inputs.hyprland.packages.${system}.default;

        hyprshot = outputs.packages.${system}.hyprshot;

        ghostty = inputs.ghostty.packages.${system}.default;
        intel-undervolt = outputs.packages.${system}.intel-undervolt;
        waybar-spotify = inputs.waybar-spotify.packages.${system}.default;
      };

      nixFrozen = {
        # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
        nix.registry.nixpkgs.flake = nixpkgs;

        # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
        environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
        nix.nixPath = [ "/etc/nix/inputs" ];
      };
    in
    rec {
      packages = forAllSystems ({ pkgs }: import ./pkgs pkgs);
      formatter = forAllSystems ({ pkgs }: pkgs.nixfmt-rfc-style);
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [ just nil nixpkgs-fmt ];
        };
      });

      nixosConfigurations =
        let
          system = x64_linux;
        in
        {
          timred = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs system;
            modules = [
              { _module.args = moduleArgs system packages; }
              ./hosts/timred
              nixFrozen
            ];
          };
          thinkpad = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs system;
            modules = [
              { _module.args = moduleArgs system packages; }
              ./hosts/thinkpad
              nixFrozen
            ];
          };
          pers-h = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs system;
            modules = [
              { _module.args = moduleArgs system packages; }
              ./hosts/pers-h
              nixFrozen
            ];
          };
          pers-c = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs aarch_linux;
            modules = [
              { _module.args = moduleArgs aarch_linux packages; }
              ./hosts/pers-c
              nixFrozen
            ];
          };
        };

      homeConfigurations = {
        "markus@timred" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs x64_linux // moduleArgs x64_linux packages;
          modules = [ ./home/timred.nix ];
        };
        "markus@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = specialArgs x64_linux // moduleArgs x64_linux packages;
          modules = [ ./home/thinkpad.nix ];
        };
        "markusnyman@MacFrier-Pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          extraSpecialArgs = specialArgs x64_darwin // moduleArgs x64_darwin packages;
          modules = [ ./home/frier.nix ];
        };
        "markus@WorkBook-Pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = specialArgs aarch_darwin // moduleArgs aarch_darwin packages;
          modules = [ ./home/work.nix ];
        };
      };
    };
}
