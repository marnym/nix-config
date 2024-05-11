{ pkgs, ... }: {
  home.packages = [ pkgs.hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text =
    let
      wallpapers-path = ../../../../../../wallpapers;
      wallpaper-files = builtins.attrNames (builtins.readDir wallpapers-path);
      wallpapers = map (file: "preload = ${wallpapers-path}/${file}") wallpaper-files;

      primary = "${wallpapers-path}/astronaut.jpg";
      secondary = "${wallpapers-path}/blockwavemoon.png";
    in
    ''
      ${builtins.concatStringsSep "\n" wallpapers}

      splash = false
      ipc = false

      wallpaper = DP-3,${primary}
      wallpaper = HDMI-A-1,${secondary}
      wallpaper = eDP-1,${secondary}
    '';
}
