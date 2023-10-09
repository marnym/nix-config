{ config, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./home-manager-thinkpad.nix
  ];
  networking.hostName = "thinkpad";

  users.users.markus.packages = with pkgs; [ acpi ];
}
