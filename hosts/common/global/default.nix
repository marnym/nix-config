{ inputs, outputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../../modules/nixos/nix-settings.nix

    ./boot.nix
    ./fish.nix
    ./locale.nix
    ./markus.nix
    ./networking.nix
  ];

  services.pcscd.enable = true;

  home-manager.extraSpecialArgs = { inherit inputs outputs pkgs; };

  system.stateVersion = "23.05";
}
