{ pkgs, idris2-pkgs } :
let
in
  pkgs.mkShell {
    packages = [
      pkgs.hello idris2-pkgs.idris2
    ];
  }
