{
  description = "Clojure dev shell";

  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      overlays = [
        (final: prev: rec {
          jdk = prev."jdk17";
          clojure = prev.clojure.override { inherit jdk; };
          leiningen = prev.leiningen.override { inherit jdk; };
        })
      ];
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit overlays system; };
    in {
      devShells = {
        ${system}.default = pkgs.mkShell {
          packages = with pkgs; [ clojure clj-kondo leiningen neil ];
        };
      };
    };
}
