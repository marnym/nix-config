{ pkgs-unstable, ... }: {
  programs.go = {
    enable = true;
    package = pkgs-unstable.go;
    goPath = ".local/share/go";
  };
}
