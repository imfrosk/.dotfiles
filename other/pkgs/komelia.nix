{ stdenv
, lib
, fetchurl
, makeWrapper
, jdk17
, zstd
, libGL
, glib
, libusb1
, udev
, xorg
, libpulseaudio
, alsa-lib
, writeShellScriptBin
}:

stdenv.mkDerivation rec {
  pname = "komelia";
  version = "0.18.4";

  src = fetchurl {
    url = "https://github.com/Snd-R/Komelia/releases/download/${version}/Komelia-${version}-linux-x64.jar";
    sha256 = "Vs+rXBLFYA0T0K5HT3rAHktog/nO5QwrU9vY3bRfgTU="; # Replace with actual hash
  };

  nativeBuildInputs = [ makeWrapper ];
  
  buildInputs = [
    jdk17
    zstd
    libGL
    glib
    libusb1
    udev
    libpulseaudio
    alsa-lib
    stdenv.cc.cc.lib
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/java $out/bin
    
    cp $src $out/share/java/komelia.jar
    
    makeWrapper ${jdk17}/bin/java $out/bin/komelia \
      --add-flags "-jar $out/share/java/komelia.jar" \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs} \
      --set JAVA_HOME ${jdk17}
  '';

  meta = with lib; {
    description = "Komga media client";
    homepage = "https://github.com/Snd-R/Komelia";
    license = licenses.mit;  # Check actual license
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
