{ pkgs, idris2-pkgs, system } :
let
  ipkgs = idris2-pkgs;
  iw = import nix/iw.nix pkgs ipkgs.idris2;
  pack = pkgs.writeShellScriptBin "pack" ''

    if [ ! -e $PACK_DIR/db ]; then
      mkdir -p $PACK_DIR && \
      ln -s ${ipkgs.pack-db}/collections $PACK_DIR/db
    fi

    exec ${pkgs.idris2Packages.pack}/bin/pack --package-set=HEAD "$@"
  '';
in
  pkgs.mkShell {
    packages = [
      ipkgs.idris2
      ipkgs.idris2Lsp
      pack
      iw
    ];

    SYSTEM = system;
  }
