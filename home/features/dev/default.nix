{ pkgs, ... }: {
  home.packages = with pkgs; [
    lazygit
    vscode

    man-pages
    man-pages-posix
    llvmPackages_16.clang
    llvmPackages_16.libcxx
    clang-tools_16
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
