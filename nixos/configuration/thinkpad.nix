{ pkgs, pkgs-unstable, inputs, outputs, ... }:

{
  imports = [
    ../configuration.nix
    ../hardware-configuration/thinkpad.nix
    ../../modules/intel-undervolt.nix
  ];

  environment.systemPackages = [ pkgs.intel-undervolt ];

  networking.hostName = "thinkpad";
}
