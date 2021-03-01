{ lib, stdenv, fetchurl, qtbase, qtsvg, qttools, qmake }:

stdenv.mkDerivation rec {
  name = "qwt-6.1.5";

  src = fetchurl {
    url = "mirror://sourceforge/qwt/${name}.tar.bz2";
    sha256 = "0hf0mpca248xlqn7xnzkfj8drf19gdyg5syzklvq8pibxiixwxj0";
  };

  propagatedBuildInputs = [ qtbase qtsvg qttools ];
  nativeBuildInputs = [ qmake ];

  postPatch = ''
    sed -e "s|QWT_INSTALL_PREFIX.*=.*|QWT_INSTALL_PREFIX = $out|g" -i qwtconfig.pri
  '';

  qmakeFlags = [ "-after doc.path=$out/share/doc/${name}" ];

  dontWrapQtApps = true;

  meta = with lib; {
    description = "Qt widgets for technical applications";
    homepage = "http://qwt.sourceforge.net/";
    # LGPL 2.1 plus a few exceptions (more liberal)
    license = lib.licenses.qwt;
    platforms = platforms.unix;
    maintainers = [ maintainers.bjornfor ];
    branch = "6";
  };
}
