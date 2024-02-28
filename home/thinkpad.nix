{ ... }:

{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/cli/linux.nix
    ./features/desktop/common/wayland/swayidle.nix
    ./features/productivity
  ];

  local.hyprland.path = ./features/desktop/hyprland/thinkpad.conf;
}
