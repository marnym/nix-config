{ pkgs, inputs, ... }:
let
  inherit (inputs) homework-template;
in
{
  home.packages = with pkgs.unstable; [
    typst
    typstfmt
    typst-lsp
  ];

  xdg.dataFile."typst/packages/local/homework-template/0.1.0".source = homework-template;
}
