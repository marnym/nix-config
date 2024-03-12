{ pkgs, ... }: {
  home.packages = [ pkgs.unstable.hyprlock ];

  xdg.configFile."hypr/hyprlock.conf".text =
    let
      bg = /home/markus/nix-config/wallpapers/blockwavemoon.png;
    in
    ''
      general {
        no_fade_in = false
        grace = 0
        disable_loading_bar = true
      }

      background {
        monitor =
        path = ${bg}
        blur_passes = 0
        # contrast = 0.8916
        # brightness = 0.8172
        # vibrancy = 0.1696
        # vibrancy_darkness = 0.0
      }

      input-field {
        monitor =
        size = 250, 60
        outline_thickness = 2
        dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        outer_color = rgba(0, 0, 0, 0)
        inner_color = rgba(0, 0, 0, 0.5)
        font_color = rgb(200, 200, 200)
        fade_on_empty = false
        placeholder_text = <i>Input Password...</i>
        hide_input = false
        position = 0, -120
        halign = center
        valign = center
      }
    '';
}
