{ inputs, ... }:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/features/docker.nix
    ../common/features/hyprland.nix
    ../common/features/mullvad.nix
    ../common/features/syncthing.nix
    ../common/features/steam.nix
  ];

  networking.hostName = "timred";
}
