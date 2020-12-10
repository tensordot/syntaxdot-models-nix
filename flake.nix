{
  description = "A very basic flake";

  inputs = rec {
    nixpkgs.follows = "syntaxdot/nixpkgs";
    syntaxdot.url = "github:tensordot/syntaxdot";
    utils.follows = "syntaxdot/utils";
  };

  outputs = { self, nixpkgs, syntaxdot, utils }:
    utils.lib.eachSystem  [ "x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      packages =
        let
          model = pkgs.callPackage ./model.nix {
            inherit (syntaxdot.packages.${system}) syntaxdot;
          };
        in {
          nl-ud-small = model {
            modelName = "nl-ud-small";
            version = "20200907";
            hash = "sha256-CR+X2pdOlViCrK+hS/8GpVn7QGvdNGAWQ/Qoi0gPZQY=";
          };
        };
    });
}
