pkgs : ipkgs :
  pkgs.writeShellScriptBin "pack" ''

    PACK_DIR="''${PACK_DIR:-''${WORKSPACE}/.pack}"

    if [ ! -e $PACK_DIR/db ]; then
      mkdir -p $PACK_DIR && \
      ln -s ${ipkgs.pack-db}/collections $PACK_DIR/db
    fi

    exec ${pkgs.idris2Packages.pack}/bin/pack --package-set=HEAD "$@"
  ''
