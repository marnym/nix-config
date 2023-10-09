# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./home-manager.nix
  ];
  networking.hostName = "koun";

  services.syncthing.devices = {
      "persC" = { id = "RMIX3JF-FQN5TTD-M62XRKG-SKVKXHJ-7ETUFPN-U4JOEG2-CFLZCSB-F4TXAQ2"; };
      "macOS" = { id = "TA4TOU5-BFEAXWC-2ZIEN6I-G6PZAND-R2ADBUQ-OIDYGKC-NC5E3E6-ZDYOZAB"; };
  };
}
