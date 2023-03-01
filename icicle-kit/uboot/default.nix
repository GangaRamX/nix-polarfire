{
  lib
, stdenv
, fetchFromGitHub
, buildPackages
, defconfig
}:

stdenv.mkDerivation rec {
  pname = "uboot";
  version = "linux4microchip+fpga-2023.02";

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
    #bc # XXX ?
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
