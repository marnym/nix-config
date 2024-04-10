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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.38.1";
    hypridle.url = "github:hyprwm/hypridle/v0.1.1";
    hyprlock.url = "github:hyprwm/hyprlock/v0.3.0";

    ghostty.url = "git+ssh://git@github.com/mitchellh/ghostty";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    waybar-spotify = {
      url = "github:marnym/waybar-spotify/5787438a07054b3081a527bc1bfc7e6cfcedea95";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homework-template = {
      url = "git+ssh://git@github.com/marnym/homework-template?rev=697fd543d130e405c5c01978da682178a666a140";
      flake = false;
    };

    ranger-devicons = {
      url = "github:alexanderjeurissen/ranger_devicons/ed718dd6a6d5d2c0f53cba8474c5ad96185057e9";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      inherit (self) outputs;

      x64_linux = "x86_64-linux";
      aarch_darwin = "aarch64-darwin";
      x64_darwin = "x86_64-darwin";
      systems = [ x64_linux aarch_darwin x64_darwin ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs { inherit system overlays; };
      });


      overlays = [
        inputs.neovim-nightly-overlay.overlay

        (self: super:
          let
            version = "v7.0-beta11";
          in
          {
            maple-mono = super.maple-mono-NF.overrideAttrs {
              inherit version;
            };
            maple-mono-NF = super.maple-mono-NF.overrideAttrs {
              inherit version;
            };
          })

        (self: super: {
          obsidian = super.obsidian.override {
            electron = super.electron_28-bin;
          };
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
        hyprland = inputs.hyprland.packages.${system}.default;

        hypridle = inputs.hypridle.packages.${system}.default;
        hypridle-module = inputs.hypridle.homeManagerModules.default;

        hyprlock = inputs.hyprlock.packages.${system}.default;
        hyprlock-module = inputs.hyprlock.homeManagerModules.default;

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
      formatter = forAllSystems ({ pkgs }: pkgs.nixpkgs-fmt);
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
