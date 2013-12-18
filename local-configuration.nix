{ config, pkgs, ... }:

{
  networking.hostName = "beast";

  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.availableKernelModules = [ "ehci_hcd" "ahci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" =
      { label = "nixos";
        fsType = "ext4";
        options = "rw,data=ordered,relatime";
        };
    "/home" =
      { label = "home";
        fsType = "ext4";
        };
  };

  swapDevices =[ ];

  nix.maxJobs = 8;
}
