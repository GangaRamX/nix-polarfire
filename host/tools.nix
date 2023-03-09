{ pkgs }:
let 
  hss = import ./hss/default.nix;
  local = ./tools.nix;
in
with pkgs;
pkgs.stdenv.mkDerivation rec {
  pname = "uboot-tools";
  version = "2021.07";

  src = fetchurl {
    url = "ftp://ftp.denx.de/pub/u-boot/u-boot-${version}.tar.bz2";
    sha256 = "sha256-MSt+6uRFgdE2LDo/AsKNgGZHdWyCuoxyJBx82+aLp34=";
  };

  patches = [ 
    ./patches/0001-drop-configh-from-tools.patch 
    ./patches/0002-tools-only-in-no-dot-config-targets.patch
    ./patches/0003-tools-Makefile-fix-C-LD-FLAGS-with-CROSS_BUILD_TOOLS.patch
  ];

  configurePhase = ''
    mkdir -p include/config
    touch include/config/auto.conf
    mkdir -p include/generated
    touch include/generated/autoconf.h
    echo '#define CONFIG_FIT_PRINT 1' >> include/generated/autoconf.h
    mkdir -p include/asm
    touch include/asm/linkage.h
    pwd
  '';

  buildFlags = [
    "CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y"
    "CONFIG_FIT=y"
    "CONFIG_MKIMAGE_DTC_PATH=dtc"
    "tools-only"];

  installPhase = ''
    mkdir -p $out
    echo ${hss}
    cp ${local} $out
    cp ${hss}/hss-payload-generator $out
    cp tools/mkimage $out
    
    chmod 0755 $out/mkimage
  '';
}

