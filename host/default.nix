with import <nixpkgs> {};
rec {
  hss = import ./hss;
  tools = callPackage ./tools.nix { };
}

