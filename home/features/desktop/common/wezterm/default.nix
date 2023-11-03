{ pkgs, ... }: {
  home.packages = [ pkgs.wezterm ];
  home.file.".config/wezterm" = {
    source = ./config;
    recursive = true;
  };
}
