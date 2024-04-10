{ config
, pkgs
, pkgs-unstable
, inputs
, hyprland
, hypridle
, hypridle-module
, hyprlock
, hyprlock-module
, hyprshot
, ghostty
, waybar-spotify
, ranger-devicons
, ...
}: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs pkgs-unstable;
      inherit hyprland hypridle hypridle-module hyprlock hyprlock-module hyprshot ghostty waybar-spotify ranger-devicons;
    };
    users.markus = import ./${config.networking.hostName}.nix;
  };
}
