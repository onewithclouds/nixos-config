# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "sd_mod" "sr_mod" "rtsx_usb_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5dfaefa6-9b88-44af-b0f4-b3f73898befc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9F6D-1493";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/caee7524-fab5-4410-b068-9cab7c0c1db9"; }
    ];

  nix.maxJobs = lib.mkDefault 4;
  nix.buildCores = 0;
  
  powerManagement.cpuFreqGovernor = "performance";
}
