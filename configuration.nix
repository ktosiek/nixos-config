# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    bluez = pkgs.bluez5;
  #  pulseaudioFull = pkgs.stdenv.lib.overrideDerivation pkgs.pulseaudioFull (oldAttrs: {
  #    name = "pulseaudio-git";
  #    src = pkgs.fetchgit {
  #      rev = "5effc834790786c456952beb7aaea7df75053889";
  #      url = "git://anongit.freedesktop.org/pulseaudio/pulseaudio";
  #      sha256 = "1a4dxq61sfj8rmgyjak15lnj2pibh0lwm3q1fiz67ck5nwgf7c3b";
  #    };
  #    patches = [];

  #    buildInputs = oldAttrs.buildInputs ++ (with pkgs; [ autoconf automake ]);

  #    preConfigure = ''
  #      echo 6.0-1-5effc834790786c456952beb7aaea7df75053889 > .tarball-version
  #      NOCONFIGURE=1 ./bootstrap.sh
  #    '' + oldAttrs.preConfigure;
  #  });
  };

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "tomek-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "lat9w-16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    psmisc
    vimNox
    nox

    # KDE
    kde4.plasma-nm
    kde4.kde_gtk_config
    oxygen-gtk2
    oxygen-gtk3
  ];
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "pl";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;
  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];
  hardware.opengl.driSupport32Bit = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.tomek = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    uid = 1000;
  };

  nix = {
    daemonIONiceLevel = 5;
    daemonNiceLevel = 10;
    buildCores = 0;
  };
}
