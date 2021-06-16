{ lib
, stdenvNoCC
, fetchurl
, makeWrapper
, syntaxdot
}:

{
  # Short name of the model. E.g.: nl-ud.
  modelName

  # Version of the model, typically a date. E.g.: 20200128
, version

  # The hash of the model.
, hash


  # Model description.
, description ? "SyntaxDot ${modelName} model"
}:

stdenvNoCC.mkDerivation rec {
  inherit version;

  pname = modelName;

  src = fetchurl {
    inherit hash;

    url = let
      fullName = "${modelName}-${version}";
    in "https://s3.tensordot.com/syntaxdot/models/${fullName}.tar.gz";
  };

  outputs = [ "bin" "out" ];

  propagatedBuildOutputs = [];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm 0644 -t $out/share/syntaxdot/models/${modelName} *

    mkdir -p $bin/bin
    makeWrapper ${syntaxdot}/bin/syntaxdot $bin/bin/syntaxdot-annotate-${modelName} \
      --add-flags annotate \
      --add-flags "$out/share/syntaxdot/models/${modelName}/syntaxdot.conf"
  '';

  meta = with lib; {
    inherit description;

    homepage = https://github.com/tensordot/syntaxdot/;
    license = licenses.unfreeRedistributable;
    maintainers = with maintainers; [ danieldk ];
    platforms = platforms.unix;
  };
}
