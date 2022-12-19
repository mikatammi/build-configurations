{ pkgs, ... } @ args:

with pkgs;

buildLinux (args // rec {
  version = "5.15.32";

  # modDirVersion needs to be x.y.z, will automatically add .0 if needed
  modDirVersion = version;

  defconfig = "imx_v8_defconfig";

  kernelPatches = [
  ];

  autoModules = false;

  extraConfig = ''
    CRYPTO_TLS m
    TLS y
    MD_RAID0 m
    MD_RAID1 m
    MD_RAID10 m
    MD_RAID456 m
    DM_VERITY m
    LOGO y
    FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER n
    FB_EFI n
    EFI_STUB y
    EFI y
    VIRTIO y
    VIRTIO_PCI y
    VIRTIO_BLK y
    DRM_VIRTIO_GPU y
    EXT4_FS y
    USBIP_CORE m
    USBIP_VHCI_HCD m
    USBIP_HOST m
    USBIP_VUDC m
  '';

  # nxp_ref = "lf-5.15.y";
  src = fetchgit {
    url = "https://source.codeaurora.org/external/imx/linux-imx";
    rev = "fa6c3168595c02bd9d5366fcc28c9e7304947a3d";
    sha256 = "sha256-Z24CpePoP28tBumTGc8ZUm/5WghuhtO2jvPOKtNaYGA=";
  };
} // (args.argsOverride or { }))
