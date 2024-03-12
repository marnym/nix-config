{
  imports = [
    ../../../modules/nixos/nix-settings.nix
    ../../../home

    ./boot.nix
    ./fish.nix
    ./locale.nix
    ./markus.nix
    ./networking.nix
  ];

  services.pcscd.enable = true;

  system.stateVersion = "23.05";
}
