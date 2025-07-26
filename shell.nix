{ pkgs, idris2-pkgs } :
let
  idris2-pkg = idris2-pkgs.idris2;
  git_z = pkgs.writeShellScriptBin "git-z" ''

    cd $WORKSPACE

    git add .

    git commit -m "z" && git push
  '';
  iw = import nix/iw.nix pkgs idris2-pkg;
in
  pkgs.mkShell {
    packages = [
      idris2-pkg
      git_z
      iw
    ];
  }
