{ stdenv, fetchurl, makeWrapper, installShellFiles, lib, pkgs, ... }:

stdenv.mkDerivation rec {
  version = "1.2.3";
  name = "hyprshot-${version}";
  src = fetchurl {
    url = "https://github.com/Gustash/Hyprshot/archive/refs/tags/${version}.tar.gz";
    hash = "sha256-AeNO7deT91lAwzbIanJ9J3UTx3sRuFMH3ki8TYis9w4=";
  };

  nativeBuildInputs = [ makeWrapper installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    cp hyprshot $out/bin/hyprshot
    wrapProgram $out/bin/hyprshot \
      --prefix PATH : ${lib.makeBinPath [ pkgs.jq pkgs.grim pkgs.slurp pkgs.wl-clipboard pkgs.libnotify ]}
  '';
}
