{ pkgs, ... }: {
  home.packages = with pkgs; [
    gcc
    gnumake
    just
    rustup
    go
    deno
    nodejs_20
    python3Minimal
    jdk17
    sqlite
  ];
}
