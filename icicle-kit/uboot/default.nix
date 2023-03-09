{
  lib
, stdenv
, fetchFromGitHub
, buildPackages
, defconfig
}:
let 
  name = "uboot";
  ver = "linux4microchip-2023.02";
in
stdenv.mkDerivation rec {
  pname = name;
  version = ver;

  src = fetchFromGitHub {
    owner = "polarfire-soc";
    repo = "u-boot";
    rev = "b356a897b11ef19dcbe7870530f23f3a978c1714";
    sha256 = "sha256-ouNLnDBeEsaY/xr5tAVBUtLlj0eylWbKdlU+bQ2Ciq4=";
  };

  depsBuildBuild = [
    buildPackages.stdenv.cc
  ];

  nativeBuildInputs = with buildPackages; [
    bison
    flex
    openssl
    which
  ];

  makeFlags = [
    "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
  ];

  configurePhase = ''
    runHook preConfigure

    make ${defconfig}_defconfig

    runHook postInstall
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp u-boot.bin u-boot.dtb $out

    runHook postConfigure
  '';
}
