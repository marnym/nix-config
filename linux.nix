{ config, pkgs, ... }:

{
  imports = [ ./core.nix ];

  home.username = "markus";
  home.homeDirectory = "/home/markus";

  home.file = {
    ".config/hypr" = {
      recursive = true;
      source = ./hypr;
    };

    ".config/fuzzel" = {
      recursive = true;
      source = ./fuzzel;
    };

    ".config/mako" = {
      recursive = true;
      source = ./mako;
    };
  };

  home.packages = with pkgs; [
    fuzzel
    libgit2_1_6
    spicetify-cli
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
