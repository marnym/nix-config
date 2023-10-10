{ pkgs, lib, ... }:

{
  imports = [ ./base/linux.nix ];

  home.file = {
    ".config/hypr" = lib.mkForce {
      recursive = true;
      source = ./config/hypr-thinkpad;
    };
  };
}
