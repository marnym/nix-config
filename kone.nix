{ config, pkgs, ... }:

{
  imports = [ ./core.nix ];

  home.username = "markus";
  home.homeDirectory = "/home/markus";

  home.packages = [
    pkgs.fuzzel
    pkgs.libgit2_1_6
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
