{ pkgs, idris2-pkgs } :
let
  git_z = pkgs.writeShellScriptBin "git-z" ''

    cd $WORKSPACE

    git add .

    git commit -m "z" && git push
  '';
in
  pkgs.mkShell {
    packages = [
      idris2-pkgs.idris2
      git_z
    ];
  }
