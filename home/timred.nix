{ ... }:

{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/productivity

    ./features/dev/jetbrains/idea.nix
    ./features/dev/jetbrains/webstorm.nix
    ./features/dev/jetbrains/goland.nix
    ./features/dev/jetbrains/pycharm.nix
    ./features/dev/jetbrains/clion.nix
    ./features/dev/jetbrains/rust-rover.nix
  ];

  local.hyprland.path = ./features/desktop/hyprland/koun.conf;
}