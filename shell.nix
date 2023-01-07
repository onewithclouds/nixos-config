with (import (fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-22.05.tar.gz) {});
mkShell {
  buildInputs = [
    nodejs-18_x 
    git
  ];
}
