{ ... }:

{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/productivity
  ];

  local.hyprland.path = ./features/desktop/hyprland/thinkpad.conf;
}
