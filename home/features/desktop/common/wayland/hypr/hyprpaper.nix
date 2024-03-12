{ pkgs, ... }: {
  home.packages = [ pkgs.hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/markus/nix-config/wallpapers/blockwavemoon.png
    preload = /home/markus/nix-config/wallpapers/dune.jpg
    preload = /home/markus/nix-config/wallpapers/astronaut.jpg

    splash = false
    ipc = false

    wallpaper = eDP-1,/home/markus/nix-config/wallpapers/blockwavemoon.png
    wallpaper = DP-3,/home/markus/nix-config/wallpapers/dune.jpg
    wallpaper = HDMI-A-1,/home/markus/nix-config/wallpapers/astronaut.jpg
  '';
}
