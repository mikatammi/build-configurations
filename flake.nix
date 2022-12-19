{
  description = "Build configurations";

  inputs = {
    nixpkgs.url = "git+https://spectrum-os.org/git/nixpkgs?ref=rootfs&rev=3176ddef4b4cec85faa2f49d29ce74816d452dc0";
    spectrum = {
      url = "github:remimimimimi/sorg-spectrum?rev=63f4440a5aea884c2c8303cf5d813e3a24425fc7";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, spectrum, flake-utils }:
  let
    config = import ./imx8qm-config.nix { nixpkgs = import nixpkgs; inherit spectrum; };
  in
  {
    packages.aarch64-linux.live = import ./release/live { inherit spectrum; inherit config; };
    packages.aarch64-linux.default = self.packages.x86_64-linux.live;
  };
}
