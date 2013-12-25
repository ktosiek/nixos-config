{ config, pkgs, ...}:

{
  imports = [
    ../modules/desktop.nix
    ../modules/tor_services.nix
    ../modules/pmount.nix ];

  services.tor.hiddenServices.ssh = true;

  security.pmount.enable = true;

  networking.hostName = "beast";

  environment.basicDesktop.enable = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.availableKernelModules = [ "ehci_hcd" "ahci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.enableAllFirmware = true;  # For wi-fi

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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  environment.systemPackages = [ pkgs.vimHugeX ];

  users.extraUsers = {
    tomek = {
      uid = 1000;
      useDefaultShell = true;
      isSystemUser = false;
      home = "/home/tomek";
      group = "tomek";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  users.extraGroups = {
    tomek = { gid = 1000; };
  };
}
