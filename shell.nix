with (import <nixpkgs> {});
with pkgs.nodePackages;

let
  nodejs = nodejs-8_x;
in mkShell {
  buildInputs = [
    indium
    javascript-typescript-langserver
    nodejs
    prettier
    typescript
  ];

  shellHook = ''
    export PATH="$PWD/bin:$PATH"
  '';
}
