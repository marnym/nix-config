{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base/core-desktop.nix
    ../../modules/intel-undervolt.nix
  ];

  networking.hostName = "thinkpad";

  environment.systemPackages = [ pkgs.acpi ];
}
