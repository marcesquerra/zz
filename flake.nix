{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    idr2nix.url = "git+https://git.sr.ht/~thatonelutenist/idr2nix?ref=trunk";
  };

  outputs = { self, nixpkgs, idr2nix }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}
