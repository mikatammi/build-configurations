final: prev:
let
  jetpack-nixos = final.fetchFromGitHub {
    owner = "anduril";
    repo = "jetpack-nixos";
    rev = "0545d8f84152421fc7dcf59678a78b8b8306d5e5";
    sha256 = "sha256-kmWOB3n+Rt1vRh4Qs4spm6+F0Gl2CuyrTmgowEe8jUs=";
  };
in
{
  nvidia-jetpack = final.callPackage (jetpack-nixos + "/default.nix") { pkgs = final; };
  # linux_imx8 = final.callPackage ./bsp/kernel/linux-imx8 { pkgs = final; };
  # linux_nvidia = final.callPackage (jetpack-nixos + "/kernel") { pkgs = final; };
  # inherit ( final.callPackage ./bsp/u-boot/imx8qm/imx-uboot.nix { pkgs = final; }) ubootImx8 imx-firmware;

  linux_latest = final.nvidia-jetpack.kernel.override { kernelPatches = []; };

  makeModulesClosure = args: prev.makeModulesClosure (args // {
    rootModules = [ "dm-verity" "loop" ];
  });

  spectrum-rootfs = prev.spectrum-rootfs.overrideAttrs (old: {
    patches = [
      ./patches/0001-Fix-console-rootfs-for-imx8qm.patch
    ];
  });

  spectrum-live = prev.spectrum-live.overrideAttrs (old: {
    pname = "build/live.img";

    patches = [
      ./patches/0002-Fix-console-liveimg-for-imx8qm.patch
    ];
  });
}
