{ pkgs, ... }: {
  home.packages = with pkgs; [
    pandoc
    glow
    librsvg
    texlive.combined.scheme-full
  ];
}
