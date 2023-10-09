{ pkgs-unstable, ... }:

{
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = pkgs-unstable;
    };
  };

  networking.hostName = "thinkpad";
}
