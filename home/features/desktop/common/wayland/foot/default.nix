{
  programs.foot =
    let
      gruvbox_material_dark = {
        background = "1d2021";
        foreground = "d4be98";

        regular0 = "1d2021";
        regular1 = "ea6962";
        regular2 = "a9b665";
        regular3 = "d8a657";
        regular4 = "7daea3";
        regular5 = "d3869b";
        regular6 = "89b482";
        regular7 = "d4be98";

        bright0 = "eddeb5";
        bright1 = "ea6962";
        bright2 = "a9b665";
        bright3 = "d8a657";
        bright4 = "7daea3";
        bright5 = "d3869b";
        bright6 = "89b482";
        bright7 = "d4be98";
      };

      rosepine = {
        background = "191724";
        foreground = "e0def4";
        regular0 = "26233a"; # black (Overlay)
        regular1 = "eb6f92"; # red (Love)
        regular2 = "31748f"; # green (Pine)
        regular3 = "f6c177"; # yellow (Gold)
        regular4 = "9ccfd8"; # blue (Foam)
        regular5 = "c4a7e7"; # magenta (Iris)
        regular6 = "ebbcba"; # cyan (Rose)
        regular7 = "e0def4"; # white (Text)

        bright0 = "6e6a86"; # bright black (Overlay)
        bright1 = "eb6f92"; # bright red (Love)
        bright2 = "31748f"; # bright green (Pine)
        bright3 = "f6c177"; # bright yellow (Gold)
        bright4 = "9ccfd8"; # bright blue (Foam)
        bright5 = "c4a7e7"; # bright magenta (Iris)
        bright6 = "ebbcba"; # bright cyan (Rose)
        bright7 = "e0def4"; # bright white (Text)
      };

      rosepine-moon = {
        background = "232136";
        foreground = "e0def4";
        regular0 = "393552"; # black (Overlay)
        regular1 = "eb6f92"; # red (Love)
        regular2 = "3e8fb0"; # green (Pine)
        regular3 = "f6c177"; # yellow (Gold)
        regular4 = "9ccfd8"; # blue (Foam)
        regular5 = "c4a7e7"; # magenta (Iris)
        regular6 = "ea9a97"; # cyan (Rose)
        regular7 = "e0def4"; # white (Text)

        bright0 = "393552"; # bright black (Overlay)
        bright1 = "eb6f92"; # bright red (Love)
        bright2 = "3e8fb0"; # bright green (Pine)
        bright3 = "f6c177"; # bright yellow (Gold)
        bright4 = "9ccfd8"; # bright blue (Foam)
        bright5 = "c4a7e7"; # bright magenta (Iris)
        bright6 = "ea9a97"; # bright cyan (Rose)
        bright7 = "e0def4"; # bright white (Text)
      };
    in
    {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "Maple Mono:size=14, Maple Mono NF:size=14";
        };
        colors = gruvbox_material_dark;
        cursor = {
          style = "beam";
          blink = "yes";
        };
      };
    };
}
