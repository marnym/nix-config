{ pkgs, ... }: {
  home.pointerCursor = {
    name = "Catppuccin-Macchiato-Dark";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Macchiato-Standard-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "yellow" ];
        variant = "macchiato";
      };
    };

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 14.0;
    };

    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark";
      package = pkgs.catppuccin-cursors.macchiatoDark;
      size = 24;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
