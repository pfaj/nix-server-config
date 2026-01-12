{ writeScriptBin }:
writeScriptBin "colgarb" ''
  nix-collect-garbage -d
  sudo nix-collect-garbage -d
''
