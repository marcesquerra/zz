{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    idr2nix.url = "git+https://git.sr.ht/~thatonelutenist/idr2nix?ref=trunk";
    idr2nixSource = {
      url = "git+https://git.sr.ht/~thatonelutenist/idr2nix?ref=trunk";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    rust_overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, idr2nix, flake-utils, rust_overlay, idr2nixSource }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {inherit system;
        overlays = [rust_overlay.overlays.default];
      };
      buildRustPlatform = dateOrVersion : channel : rustic :
        let
          rustChannel =
            if channel == "stable" then rustic.rust-bin.stable.${dateOrVersion}
            else rustic.rustChannelOf { inherit channel; date = dateOrVersion; };
          rust = rustChannel.default;
          nixRustPlatform = rustic.makeRustPlatform { cargo = rust; rustc = rust; };
          getFromCargo = {src, cargoHash, nativeBuildInputs ? [], cargoBuildFlags ? []} :
            let
              lib = rustic.lib;
              asName = candidates :
                let
                  ts = e: if (builtins.isAttrs e) && (builtins.hasAttr "name" e) && e.name != null then e.name else toString e;
                  stringCandidates = builtins.map ts candidates;
                  wholeString = lib.concatStrings stringCandidates;
                in
                  builtins.hashString "sha256" wholeString;
            in
              nixRustPlatform.buildRustPackage rec {
                inherit src cargoHash nativeBuildInputs cargoBuildFlags;
                pname = "cargo-${asName [src]}";
                version = "N/A";
                doCheck = false;
              };
        in {inherit rustChannel getFromCargo nixRustPlatform;};
      rust1_76_0 = buildRustPlatform "1.76.0" "stable" pkgs;
      getFromCargo = rust1_76_0.getFromCargo;
      idr2nixBinary = getFromCargo {
        src = idr2nixSource;
        cargoHash = "sha256-93FtAbscmTNmAH8lED++SYU5gtoWTLIXt8OgSgkQF+Y=";
        nativeBuildInputs = [
          pkgs.openssl
          pkgs.openssl.dev
          pkgs.pkg-config
        ];
      };
    in
      rec {

        packages.${system} = {
          hello = pkgs.hello;
          default = self.packages.${system}.hello;
        };

        devShells = {
          default = pkgs.mkShell {
            packages = [
              # idr2nix.packages.${system}.default
              pkgs.hello
              # idr2nixBinary
            ];
          };
        };

      }
  );
}
