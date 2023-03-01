{pkgs, lib, stdenv}:
let
  linux = pkgs.linuxManualConfig rec {
    inherit lib stdenv;
    version = "5.15.92-linux4microchip+fpga-2023.02";
    src = pkgs.fetchFromGitHub {
      owner = "linux4microchip";
      repo = "linux";
      rev = "360a547daec2a69169be49d3da9cca8b1ecb325f";
      sha256 = "sha256-ri2d91bHmcFkV2PjwRNho1XQixKttJKoG/qiOdeB01M=";
    };

    configfile = ./defconfig;
  };
in 
  linux


