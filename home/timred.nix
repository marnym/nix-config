{ ... }:

{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/productivity
    ./features/jetbrains
  ];

  local.hyprland.path = ./features/desktop/hyprland/koun.conf;
}
