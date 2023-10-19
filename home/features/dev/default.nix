{ pkgs, ... }: {
  home.packages = with pkgs; [
    gcc
    gnumake
    just
    rustup
    go
    deno
    nodejs_20
    jdk17
    sqlite
  ];
}
