{ ... }:

{
  imports = [
    ../base/desktop

    ./server
    ./desktop
  ];

  local.hyprland.path = ./desktop/hyprland/koun.conf;
}
