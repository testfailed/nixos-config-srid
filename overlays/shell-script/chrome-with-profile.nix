# final: prev: {

{ stdenv, fetchurl }:

stdenv.mkDerivation {
  name = "chrome-with-profile";
  src = fetchurl {
    url = "http://example.org/libfoo-1.2.3.tar.bz2";
    hash = "sha256-tWxU/LANbQE32my+9AXyt3nCT7NBVfJ45CX757EMT3Q=";
  };
  # outputHashMode = "recursive";
  # outputHashAlgo = "sha256";
  # builder =
}
# }
