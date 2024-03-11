{ pkgs, ... }: {
  home.packages = [ pkgs.glow ];

  xdg.configFile."glow/glow.yml".text = /* yaml */ ''
    local: true
    mouse: true
    width: 120
  '';
}
