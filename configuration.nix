{ config, pkgs, ... }:

{
  imports = [ ./local-configuration.nix ];

  networking = {
    networkmanager.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "pl";
  };
  # services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.slim.enable = true;
  services.xserver.windowManager.i3.enable = true;

  environment = {
    systemPackages = [ pkgs.vimHugeX ];
  };

  fonts.enableCoreFonts = true;
  fonts.extraFonts = [ pkgs.ubuntu_font_family pkgs.dejavu_fonts ];

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
