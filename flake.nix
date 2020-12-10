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
          de-ud-large = model {
            modelName = "de-ud-large";
            version = "20200812";
            hash = "sha256-/ixfUz+ygLYMxr8Cy0N08lEwqJtWzcOX0/PkjZUGCOg=";
          };
          de-ud-medium = model {
            modelName = "de-ud-medium";
            version = "20200831";
            hash = "sha256-28xkJ6sFR71FfGzCnwjzQCoDXZ5pH2lNRJrDALoWrRk=";
          };
          de-ud-small = model {
            modelName = "de-ud-small";
            version = "20200907";
            hash = "sha256-Ns76DVQK5/k7bcbh4mp8oKiB6eLFQkcU8s3AfrdMxaI=";
          };
          nl-ud-large = model {
            modelName = "nl-ud-large";
            version = "20200812";
            hash = "sha256-uhRhzabHNKwJsSKt4S8xuF0Trb/bE7dGyGCFS+cfnE8=";
          };
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
