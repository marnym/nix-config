{ pkgs, pkgs-unstable, ... }: {
  imports = [
    ./golang.nix
  ];

  home.packages = with pkgs; [
    lazygit
    vscode

    man-pages
    man-pages-posix
    gcc13
    libcxx
    gnumake
    just
    pkgs-unstable.deno
    nodejs_20
    python3Minimal
    jdk17
    sqlite
  ];
}
