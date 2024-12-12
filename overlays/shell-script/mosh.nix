{ stdenv, fetchurl, lib, ... }:

# TODO: .pkg is not a valid format for nixpkgs.
stdenv.mkDerivation {
  pname = "mosh";
  version = "1.4.0";

  src = fetchurl {
    url = "https://github.com/mobile-shell/mosh/releases/download/mosh-1.4.0/mosh-1.4.0.pkg";
    sha256 = "01xjlisp0pl7qqmgy1xv3f9292pqj7d48b8hhjrggzqd19zfzlql";
  };

  # Installation steps if necessary
  unpackPhase = "true"; # If the binary doesn't need unpacking, you can skip this phase
  buildInputs = [ ];
  meta = with lib; {
    description = "Mosh - Remote terminal application";
    license = licenses.mit;
  };
}
