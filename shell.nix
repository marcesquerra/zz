{ pkgs, idris2-pkgs } :
let
  idris2-pkg = idris2-pkgs.idris2;
  iw = import nix/iw.nix pkgs idris2-pkg;
in
  pkgs.mkShell {
    packages = [
      idris2-pkg
      iw
    ];
  }
