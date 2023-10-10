{ ... }:

{
  imports = [ ./base/linux.nix ];

  local.hyprland.path = ./hyprland/thinkpad.conf;
}
