pkgs : rec {
  writeNuScriptBin = name : body : pkgs.writeTextFile {
    name = name;
    text = ''
      #! ${pkgs.nushell}/bin/nu --stdin
      ${body}
    '';
    executable = true;
    destination = "/bin/${name}";
  };
}
