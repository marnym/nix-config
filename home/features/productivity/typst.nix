{ pkgs, ... }: {
  home.packages = with pkgs.unstable; [
    typst
    typstfmt
    typst-lsp
  ];
}
