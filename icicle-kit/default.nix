with import <nixpkgs> {
  crossSystem = {
    config = "riscv64-unknown-linux-gnu";
  };
  overlays = [ (self: super: { gcc = self.gcc11; }) ];
};
rec {

  uboot-polarfire-icicle-kit = callPackage ./uboot { defconfig = "microchip_mpfs_icicle"; };
  linux-polarfire-icicle-kit = callPackage ./linux { };
}
