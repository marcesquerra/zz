{ pkgs, idris2-pkgs, system } :
let
  ipkgs = idris2-pkgs;
  iw = import nix/iw.nix pkgs ipkgs.idris2;
  pack = import nix/pack.nix pkgs ipkgs;
  ci = import nix/ci.nix pkgs ipkgs;
in
  pkgs.mkShell {
    packages = [
      ipkgs.idris2
      ipkgs.idris2Lsp
      pack
      iw
      ci
    ];

    SYSTEM = system;
  }
