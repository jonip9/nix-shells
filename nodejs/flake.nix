{
  description = "JavaScript dev shell";

  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells = {
        ${system}.default = pkgs.mkShell {
          packages = with pkgs; [ nodejs_18 nodePackages.typescript-language-server typescript ];
        };
      };
    };
}
