{ config, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./home-manager-thinkpad.nix
  ];
  networking.hostName = "thinkpad";
}
