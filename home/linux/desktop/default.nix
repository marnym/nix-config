{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland
    ./firefox.nix
    ./gammastep.nix
  ];

  programs.git.signing.signByDefault = lib.mkForce false;

  home.file = {
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
    spicetify-cli
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
