let pkgs = import <nixpkgs> {};

in pkgs.mkShell rec {
   name = "webdev";

   buildInputs = with pkgs; [
   	       nodejs-10_x
	       (yarn.override { nodejs = nodejs-10_x; })
	       ];
}
	       