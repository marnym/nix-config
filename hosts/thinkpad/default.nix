{ inputs, pkgs, ... }:

{
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t490

    ./hardware-configuration.nix

    ../common/global
    ../common/features/docker.nix
    ../common/features/hyprland.nix
    ../common/features/intel-undervolt.nix
    ../common/features/mullvad.nix
    ../common/features/syncthing.nix
  ];

  networking.hostName = "thinkpad";

  environment.systemPackages = [ pkgs.acpi ];
}
