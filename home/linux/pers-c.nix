{ ... }:

{
  imports = [
    ../base/server

    ./server
  ];

  local.hyprland.path = ./desktop/hyprland/koun.conf;
}
