{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "intel-undervolt-${version}";
  version = "1.7";
  src = fetchurl {
    url = "https://github.com/kitsunyan/intel-undervolt/archive/refs/tags/${version}.tar.gz";
    hash = "sha256-KafrruSDDWXQtc76bUl4h9TyPzRlmHbf6UTzoCDPM/8=";
  };

  makeFlags = [ "DESTDIR=$(out)" "BINDIR=/bin" ];
}
