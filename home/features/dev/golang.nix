{ pkgs, ... }: {
  programs.go = {
    enable = true;
    package = pkgs.unstable.go;
    goPath = ".local/share/go";
  };
}
