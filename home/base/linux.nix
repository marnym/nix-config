{ pkgs, lib, ... }:

{
  imports = [
    ./core.nix
    ../hyprland
  ];

  home.username = "markus";
  home.homeDirectory = "/home/markus";

  programs.git.signing.signByDefault = lib.mkForce false;

  home.file = {
    ".config/fuzzel" = {
      recursive = true;
      source = ../config/fuzzel;
    };

    ".config/mako" = {
      recursive = true;
      source = ../config/mako;
    };
  };

  home.packages = with pkgs; [
    fuzzel
    spicetify-cli
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../config/eww;
  };
}
