{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../base.nix
    ../../modules/intel-undervolt.nix
  ];

  networking.hostName = "thinkpad";

  environment.systemPackages = [
    pkgs.acpi
    pkgs.intel-undervolt
  ];
}
