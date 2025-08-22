pkgs : ipkgs :

ipkgs.buildIdris' {
  ipkgName = "hello2";
  src = ./.;
}
