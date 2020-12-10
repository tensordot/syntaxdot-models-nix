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
          nl-ud-medium = model {
            modelName = "nl-ud-medium";
            version = "20200812";
            hash = "sha256-afHz6ZNPHR7KYiSAL5FRWkLxk+gourn4AG/dV9d+Q1M=";
          };
          nl-ud-small = model {
            modelName = "nl-ud-small";
            version = "20200907";
            hash = "sha256-CR+X2pdOlViCrK+hS/8GpVn7QGvdNGAWQ/Qoi0gPZQY=";
          };
        };
    });
}
