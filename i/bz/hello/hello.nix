pkgs : ipkgs :

ipkgs.buildIdris' {
  ipkgName = "hello";
  src = ./.;
}
