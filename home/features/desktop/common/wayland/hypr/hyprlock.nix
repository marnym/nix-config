{ hyprlock, hyprlock-module, ... }: {
  imports = [ hyprlock-module ];

  programs.hyprlock = {
    enable = true;
    package = hyprlock;

    general = {
      disable_loading_bar = true;
    };

    backgrounds = [{
      path = "/home/markus/nix-config/wallpapers/blockwavemoon.png";
    }];

    input-fields = [{
      size = {
        width = 250;
        height = 60;
      };
      outline_thickness = 2;
      dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true;
      outer_color = "rgba(0, 0, 0, 0)";
      inner_color = "rgba(0, 0, 0, 0.5)";
      font_color = "rgb(200, 200, 200)";
      fade_on_empty = false;
      placeholder_text = "<i>Input Password...</i>";
      hide_input = false;
      position = {
        x = 0;
        y = -120;
      };
      halign = "center";
      valign = "center";
    }];

    labels = [ ];
  };
}
