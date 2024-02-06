{ pkgs, ... }: {
  # todo)) Rose Piné cursor
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
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
      size = 24;
    };

    iconTheme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-icon-theme;
    };
  };
}
