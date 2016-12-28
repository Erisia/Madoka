# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "tank/nixos";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "tank/nixos/nix";
      fsType = "zfs";
    };

  fileSystems."/var" =
    { device = "tank/nixos/var";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "tank/home";
      fsType = "zfs";
    };

  fileSystems."/var/lib/docker" =
    { device = "tank/nixos/var/lib-docker";
      fsType = "zfs";
    };

  fileSystems."/home/svein" =
    { device = "tank/home/svein";
      fsType = "zfs";
    };

  fileSystems."/home/minecraft" =
    { device = "tank/home/minecraft";
      fsType = "zfs";
    };

  fileSystems."/home/minecraft/incognito" =
    { device = "tank/home/minecraft/incognito";
      fsType = "zfs";
    };

  fileSystems."/home/minecraft/erisia" =
    { device = "tank/home/minecraft/erisia";
      fsType = "zfs";
    };

  fileSystems."/home/minecraft/incognito/dynmap" =
    { device = "tank/home/minecraft/incognito/dynmap";
      fsType = "zfs";
    };

  fileSystems."/home/minecraft/erisia/dynmap" =
    { device = "tank/home/minecraft/erisia/dynmap";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/c68b0eab-859b-40ff-aad6-3619814cd017";
      fsType = "btrfs";
    };

  fileSystems."/home/xgas" =
    { device = "tank/home/xgas";
      fsType = "zfs";
    };

  fileSystems."/home/tppi" =
    { device = "tank/home/tppi";
      fsType = "zfs";
    };

  fileSystems."/home/tppi/server" =
    { device = "tank/home/tppi/server";
      fsType = "zfs";
    };

  fileSystems."/home/tppi/server/dynmap" =
    { device = "tank/home/tppi/server/dynmap";
      fsType = "zfs";
    };

  swapDevices = [];

  nix.maxJobs = lib.mkDefault 8;
}
