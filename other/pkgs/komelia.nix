{ lib
, stdenv
, fetchurl
, jdk17
, gradle
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "komelia";
  version = "unstable-2025-01-27";

  src = fetchurl {
    url = "https://github.com/Snd-R/Komelia/releases/download/0.17.0/Komelia-0.17.0-linux-x64.jar";
    sha256 = "sha256-G2ypWE0bLraqlHIcD53raIT/6zNcxe6roN00kgji9Ic=";
  };

  nativeBuildInputs = [ jdk17 gradle makeWrapper ];

  buildPhase = ''
    # Skip native builds and use whatever is in the repo
    ./gradlew --no-daemon :komelia-app:repackageUberJar -x komeliaBuildNonJvmDependencies
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/komelia
    
    find . -name "*.jar" -path "*/compose/jars/*" -exec cp {} $out/share/komelia/komelia.jar \;

    makeWrapper ${jdk17}/bin/java $out/bin/komelia \
      --add-flags "-jar $out/share/komelia/komelia.jar"
  '';

  GRADLE_USER_HOME = "/tmp/gradle-home";

  meta = with lib; {
    description = "A modern and efficient client for Komga";
    homepage = "https://github.com/Snd-R/Komelia";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "komelia";
  };
}
