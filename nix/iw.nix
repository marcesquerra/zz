pkgs : idris2-pkg :

let
  idris2 = "${idris2-pkg}/bin/idris2";
  validate = ''
    function error () {
      echo "ERROR:"
      echo "$1"
      echo
      echo "USAGE"
      echo "  iw build ipkg-name"
      echo
      echo "NOTE: Make sure ipkg-name does not include the 'ipkg' extension"
      exit 1
    }

    if [[ "$1" == "build" ]]; then
      IPKG_FILE="$2.ipkg"

      if [ ! -f "$IPKG_FILE" ]; then
          error "  Can't load the ipkg file '$IPKG_FILE'"
      fi
    else
      error "  Command missing"
    fi
  '';
  idris2-run = pkgs.writeShellScriptBin "idris2-run" ''

    ${validate}

    if [[ "$1" == "build" ]]; then
      COMMAND_DESCRIPTION="Building"
      IPKG_FILE="$2.ipkg"

      I2_COMMANDS=("--build" $IPKG_FILE)
    else
      error "  Command missing"
    fi

    BOLD='\033[1;37m'
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color

    handler() {
      exit 1
    }

    trap handler SIGINT

    echo                                                    && \
    echo                                                    && \
    printf "$COMMAND_DESCRIPTION $YELLOW$IPKG_FILE$NC"      && \
    echo                                                    && \
    echo                                                    && \
    ${idris2} "''${I2_COMMANDS[@]}"
    EC="$?"
    echo                                                    && \
    printf "Waiting for changes...  (Press <''${BOLD}Ctrl-c''${NC}> to interrupt)  "
    exit $EC
  '';
in
  pkgs.writeShellScriptBin "iw" ''

    ${validate}

    CONTINUE="true"

    ${pkgs.fd}/bin/fd -a -c never -t f --search-path src

    while [[ $CONTINUE == "true" ]]; do
      (${pkgs.fd}/bin/fd -c never -t f --search-path src | ${pkgs.entr}/bin/entr -d ${idris2-run}/bin/idris2-run "$@") && CONTINUE="false"
    done
  ''
