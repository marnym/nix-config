let
  gruvbox-material = ''
    background = 1d2021
    foreground = d4be98

    palette = 0=#1d2021
    palette = 1=#ea6962
    palette = 2=#a9b665
    palette = 3=#d8a657
    palette = 4=#7daea3
    palette = 5=#d3869b
    palette = 6=#89b482
    palette = 7=#d4be98

    palette = 8=#eddeb5
    palette = 9=#ea6962
    palette = 10=#a9b665
    palette = 11=#d8a657
    palette = 12=#7daea3
    palette = 13=#d3869b
    palette = 14=#89b482
    palette = 15=#d4be98
  '';

  rosepine = ''
    background = 191724 
    foreground = e0def4 

    palette = 0=#26233a 
    palette = 1=#eb6f92 
    palette = 2=#31748f 
    palette = 3=#f6c177 
    palette = 4=#9ccfd8 
    palette = 5=#c4a7e7 
    palette = 6=#ebbcba 
    palette = 7=#e0def4 

    palette = 8=#6e6a86 
    palette = 9=#eb6f92 
    palette = 10=#31748f
    palette = 11=#f6c177
    palette = 12=#9ccfd8
    palette = 13=#c4a7e7
    palette = 14=#ebbcba
    palette = 15=#e0def4
  '';

  rosepine-moon = ''
    background = 232136
    foreground = e0def4

    palette = 0=#393552	
    palette = 1=#eb6f92	
    palette = 2=#3e8fb0 
    palette = 3=#f6c177 
    palette = 4=#9ccfd8	
    palette = 5=#c4a7e7	
    palette = 6=#ea9a97	
    palette = 7=#e0def4 

    palette = 8=#393552	
    palette = 9=#eb6f92 
    palette = 10=#3e8fb0
    palette = 11=#f6c177
    palette = 12=#9ccfd8
    palette = 13=#c4a7e7
    palette = 14=#ea9a97
    palette = 15=#e0def4
  '';
in
{
  home.file.".config/ghostty/config".text = ''
    font-size = 13
    font-family = "Maple Mono"
    font-family = "Maple Mono NF"

    font-feature = calt
    font-feature = zero
    font-feature = ss01

    background-opacity = 0.95
    background-blur-radius = 20

    gtk-titlebar = false

    confirm-close-surface = false

    macos-non-native-fullscreen = visible-menu
    macos-option-as-alt = left

    ${gruvbox-material}
  '';
}
