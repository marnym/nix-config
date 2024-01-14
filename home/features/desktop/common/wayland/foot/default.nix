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
    in
    {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "Cascadia Code:size=14";
        };
        colors = gruvbox_material_dark;
        cursor = {
          style = "beam";
          blink = "yes";
        };
      };
    };
}
