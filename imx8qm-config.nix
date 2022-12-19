{ nixpkgs ? import <nixpkgs>, spectrum }:
let
  config = {
    pkgs = nixpkgs {
      system = "aarch64-linux";
      overlays = [
        (import ./overlays/common.nix { inherit spectrum; inherit config; })
        (import ./overlays/imx8qm.nix)
      ];
    };
};
in
  config
