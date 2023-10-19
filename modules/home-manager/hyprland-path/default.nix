{ config, lib, ... }:

with lib;
let
  cfg = config.local.hyprland;
in
{
  options.local.hyprland.path = mkOption {
    type = types.path;
  };

  config.home.file = {
    ".config/hypr/core.conf".source = ./core.conf;
    ".config/hypr/hyprland.conf".source = cfg.path;
  };
}
