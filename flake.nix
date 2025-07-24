{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    Idris2 = {
      url = "github:idris-lang/Idris2";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, flake-utils, Idris2 }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {inherit system;};
    in
      rec {

        packages.${system} = {
          hello = pkgs.hello;
          default = self.packages.${system}.hello;
        };

        devShells = {
          default = pkgs.mkShell {
            packages = [
              pkgs.hello Idris2.packages.${system}.idris2
            ];
          };
        };

      }
  );
}
