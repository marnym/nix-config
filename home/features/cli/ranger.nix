{ pkgs, inputs, ... }:
let
  inherit (inputs) ranger-devicons;

  config = ''
    default_linemode devicons

    set show_hidden true

    set preview_images true
    # todo)) set preview_images_method sixel
    set preview_images_method ueberzug
  '';
in
{
  # TODO)) once in version
  # programs.ranger = {
  #   enable = true;
  #   extraConfig = config;
  # };

  home.packages = [ pkgs.ranger pkgs.ueberzugpp ];

  xdg.configFile."ranger/rc.conf".text = config;
  xdg.configFile."ranger/plugins/ranger_devicons".source = ranger-devicons;
}
