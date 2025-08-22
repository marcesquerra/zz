{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    pack-db = {
      url = "github:/stefan-hoeck/idris2-pack-db/2d2d67aac9e3f40388e486916a03150ad858aae9";
      flake = false;
    };
    idris2Lsp = {
      url = "github:idris-community/idris2-lsp/eba489fbde228a4e7ef423d19236813f7ca7cbac";
      flake = true;
      # This puts a fake idris2Lsp into the idris2Lsp, to avoid a recursion problem
      inputs.idris2Lsp.follows = "nixpkgs";
    };
    idris2-packages-set = {
      url = "github:mattpolzin/nix-idris2-packages/e24745170541d8f7765d1eab0b5f9974ae32d95b";
      flake = true;
      inputs.idris2Lsp.follows = "idris2Lsp";
      inputs.idris2PackDbSrc.follows = "pack-db";
    };
  };

  outputs = { self, nixpkgs, flake-utils, idris2-packages-set, pack-db, ... }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {inherit system;};
      idris2-pkgs = idris2-packages-set.packages.${system} // {inherit pack-db;};
    in
      rec {

        packages = rec {
          hello = import i/bz/hello/hello.nix pkgs idris2-pkgs;
          hello2 = import i/bz/hello2/hello2.nix pkgs idris2-pkgs;
          default = hello;
        };

        devShells = rec {
          default = import ./shell.nix {
            inherit pkgs idris2-pkgs system;
          };
        };

      }
  );
}
