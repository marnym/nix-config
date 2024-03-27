{ pkgs, ... }: {
  home.packages = with pkgs; [
    pandoc
    librsvg
    texlive.combined.scheme-full
  ];
}
