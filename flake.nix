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
          de-ud-huge = model {
            modelName = "de-ud-huge";
            version = "20210307";
            hash = "sha256-ySsCAlgEGm/QX322PhfVyZH8SLHzWVFglJTkf4cAbKc=";
            description = "Huge German UD syntax model, 12 layers, 768 hidden units";
          };
          de-ud-large = model {
            modelName = "de-ud-large";
            version = "20210326";
            hash = "sha256-QnbCXjuursqaA6RCPXroeNb7jbexdUhk8uCn7mRvwUQ=";
            description = "Large German UD syntax model, 12 layers, 384 hidden units";
          };
          de-ud-large-albert = model {
            modelName = "de-ud-large-albert";
            version = "20210402";
            hash = "sha256-+xo+82Mt0GYhOUBbBpI8l1GaajFeepDuEmDUY7k6SRU=";
            description = "Large German UD syntax model, 12 layers, 384 hidden units, layer sharing";
          };
          de-ud-medium = model {
            modelName = "de-ud-medium";
            version = "20210326";
            hash = "sha256-60eIrnEzTkJ1+fU2xD0xUwXgly4R7cddSR5UUN1w2+g=";
            description = "Medium German UD syntax model, 6 layers, 384 hidden units";
          };
          nl-ud-huge = model {
            modelName = "nl-ud-huge";
            version = "20210301";
            hash = "sha256-R9AU9gpUVVAjP8ENv8VxfQLiVAaR0ha2n3TmSOLHEWk=";
            description = "Huge Dutch UD syntax model, 12 layers, 768 hidden units";
          };
          nl-ud-large = model {
            modelName = "nl-ud-large";
            version = "20210324";
            hash = "sha256-aJqO+wOiNmpZdB5eMaH5sgx74rhEWO2O7U9cwxMznKc=";
            description = "Large Dutch UD syntax model, 12 layers, 384 hidden units";
          };
          nl-ud-large-albert = model {
            modelName = "nl-ud-large-albert";
            version = "20210331";
            hash = "sha256-uzlW78K7gMOyXA93ofBPWet5uPvE+VvGGuAgg1sFPTY=";
            description = "Large Dutch UD syntax model, 12 layers, 384 hidden units, layer sharing";
          };
          nl-ud-medium = model {
            modelName = "nl-ud-medium";
            version = "20210312";
            hash = "sha256-J2SusHWp+757XFLWXSs2pi7EdSrhigmpM76HAKPF7To=";
            description = "Medium Dutch UD syntax model, 6 layers, 384 hidden units";
          };
        };
    });
}
