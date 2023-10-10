{ ... }:

{
  imports = [
    ./base/linux.nix
  ];

  local.hyprland = {
    path = ./hyprland/koun.conf;
  };
}
