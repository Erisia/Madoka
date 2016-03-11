# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "storage/nixos";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "storage/nixos/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "storage/home";
      fsType = "zfs";
    };

  fileSystems."/home/minecraft" =
    { device = "storage/home/minecraft";
      fsType = "zfs";
    };

  fileSystems."/home/svein" =
    { device = "storage/home/svein";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4969110d-851b-40bd-9c54-082388286457";
      fsType = "btrfs";
    };

  fileSystems."/var/gitlab" =
    { device = "storage/var/gitlab";
      fsType = "zfs";
    };

  fileSystems."/var/db/postgresql" =
    { device = "storage/var/postgresql";
      fsType = "zfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ee79a0d3-7a79-4251-a885-df8b49680113"; }
    ];

  nix.maxJobs = 8;
}
