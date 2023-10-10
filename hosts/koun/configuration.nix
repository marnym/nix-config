{ pkgs, pkgs-unstable, inputs, ... }:

{
  imports = [
    ../../nixos/system.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = pkgs-unstable;
      hyprland-flake = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };

  networking.hostName = "koun";

  services.syncthing.devices = {
    "persC" = { id = "RMIX3JF-FQN5TTD-M62XRKG-SKVKXHJ-7ETUFPN-U4JOEG2-CFLZCSB-F4TXAQ2"; };
    "macOS" = { id = "TA4TOU5-BFEAXWC-2ZIEN6I-G6PZAND-R2ADBUQ-OIDYGKC-NC5E3E6-ZDYOZAB"; };
  };
}
