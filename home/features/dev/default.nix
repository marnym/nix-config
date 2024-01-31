{ pkgs, ... }: {
  home.packages = with pkgs; [
    lazygit
    vscode

    man-pages
    man-pages-posix
    libcxx
    clang-tools_17
    gnumake
    just
    unstable.go
    unstable.deno
    nodejs_20
    python3Minimal
    jdk17
    sqlite
  ];
}
