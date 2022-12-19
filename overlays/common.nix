{ spectrum, config ? import (spectrum + "/nix/eval-config.nix") {} }:

final: prev: {
  crosvm = final.callPackage ./packages/crosvm { inherit (prev) crosvm; };
  usbutils = final.callPackage ./packages/usbutils {inherit (prev) usbutils; };
  spectrum-rootfs = import (spectrum + "/host/rootfs") { inherit config; };
  spectrum-live = import (spectrum + "/release/live") { inherit config; };
}
