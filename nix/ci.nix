pkgs : ipkgs :
let
  lib = import ./lib.nix pkgs;
  pack =
    let
      nix-package = import ./pack.nix pkgs ipkgs;
    in "${nix-package}/bin/pack";
in
  lib.writeNuScriptBin "ci" ''
    def "main test" [] {

      cd $env.WORKSPACE

      cd i/bz/hello2
      ^${pack} test hello2
    }

    def "main" [] {
      help main
    }
  ''
