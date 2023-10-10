{ ... }:

{
  imports = [
    ./base/linux.nix
  ];

  local.hyprland.path = ./desktop/hyprland/koun.conf;
}
