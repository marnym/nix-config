{ pkgs, ... }: {
  # todo)) Rose Piné cursor
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 30;
  };

  gtk = {
    enable = true;

    theme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-gtk-theme;
    };

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 14.0;
    };

    # todo)) Rose Piné cursor
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 40;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
