{
  description = "SyntaxDot models";

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
            version = "20210326";
            hash = "sha256-QnbCXjuursqaA6RCPXroeNb7jbexdUhk8uCn7mRvwUQ=";
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
          nl-ud-huge = model {
            modelName = "nl-ud-huge";
            version = "20210301";
            hash = "sha256-R9AU9gpUVVAjP8ENv8VxfQLiVAaR0ha2n3TmSOLHEWk=";
          };
          nl-ud-large = model {
            modelName = "nl-ud-large";
            version = "20210324";
            hash = "sha256-aJqO+wOiNmpZdB5eMaH5sgx74rhEWO2O7U9cwxMznKc=";
          };
          nl-ud-large-albert = model {
            modelName = "nl-ud-large-albert";
            version = "20210331";
            hash = "sha256-uzlW78K7gMOyXA93ofBPWet5uPvE+VvGGuAgg1sFPTY=";
          };
          nl-ud-medium = model {
            modelName = "nl-ud-medium";
            version = "20210312";
            hash = "sha256-J2SusHWp+757XFLWXSs2pi7EdSrhigmpM76HAKPF7To=";
          };
        };
    });
}
