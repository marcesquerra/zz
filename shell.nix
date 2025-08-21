{ pkgs, idris2-pkgs, system } :
let
  ipkgs = idris2-pkgs;
  iw = import nix/iw.nix pkgs ipkgs.idris2;
in
  pkgs.mkShell {
    packages = [
      ipkgs.idris2
      ipkgs.idris2Lsp
      iw
    ];

    SYSTEM = system;
  }
