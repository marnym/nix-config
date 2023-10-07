{ config, pkgs, ... }:

{
  imports = [
    /home/markus/.dotfiles/nixos/core.nix
    ./home-manager-thinkpad.nix
  ];
  networking.hostName = "thinkpad";
}
