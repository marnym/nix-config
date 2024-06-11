{ config
, pkgs
, pkgs-unstable
, inputs
, hyprland
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
      inherit hyprland hyprshot ghostty waybar-spotify ranger-devicons;
    };
    users.markus = import ./${config.networking.hostName}.nix;
  };
}
