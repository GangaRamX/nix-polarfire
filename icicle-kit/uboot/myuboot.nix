{ pkgs ,
  targetBoard,
}:
with pkgs; let
  inherit buildUBoot;

in {
  ubootIcicle = buildUBoot {
    pname = "uboot";
    version = "linux4microchip+fpga-2023.02";

    src = fetchFromGitHub {
    owner = "polarfire-soc";
    repo = "u-boot";
    rev = "b356a897b11ef19dcbe7870530f23f3a978c1714";
    sha256 = "sha256-ouNLnDBeEsaY/xr5tAVBUtLlj0eylWbKdlU+bQ2Ciq4=";
  };

    defconfig = "${targetBoard}_defconfig";
    extraMeta.platforms = ["riscv64-linux"];
    filesToInstall = [ "uboot.bin" ];
  };
}


