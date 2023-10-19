{ ... }: {
  imports = [
    ../../../modules/nixos/nix-settings.nix

    ./boot.nix
    ./fish.nix
    ./locale.nix
    ./markus.nix
    ./networking.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;

  system.stateVersion = "23.05";
}
