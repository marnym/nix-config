{ ... }:

{
  imports = [ ./base/linux.nix ];

  local.hyprland.path = ./desktop/hyprland/thinkpad.conf;
}
