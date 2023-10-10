{ pkgs, lib, ... }:

{
  imports = [ ../../core.nix ];

  home.username = "markus";
  home.homeDirectory = "/home/markus";

  programs.git.signing.signByDefault = lib.mkForce false;

  home.file = {
    ".config/hypr" = {
      recursive = true;
      source = ../../../hypr;
    };

    ".config/fuzzel" = {
      recursive = true;
      source = ../../../fuzzel;
    };

    ".config/mako" = {
      recursive = true;
      source = ../../../mako;
    };
  };

  home.packages = with pkgs; [
    fuzzel
    spicetify-cli
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../../../eww;
  };
}
