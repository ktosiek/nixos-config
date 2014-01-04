/* Basic desktop parts. Adds NetworkManager, X11, CUPS etc. */

{config, pkgs, ...}:

 let
   cfg = config.environment.basicDesktop;
 in

 with pkgs.lib;

 {
   options = {
     environment.basicDesktop = {
       enable = mkOption {
         default = false;
         type = types.bool;
         description = ''
           Enable some common desktop parts, like X11 or CUPS.
         '';
       };
     };
   };

   config = mkIf cfg.enable {

    # Make NetworkManager manage all networking
    networking = {
      networkmanager.enable = true;
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    hardware.pulseaudio.enable = true;

    services.upower.enable = true;
    services.udisks2.enable = true;

    # Enable the X11 windowing system.
    services.xserver = {
      enable = true;
      layout = "pl";
      synaptics.enable = true;

      displayManager.slim.enable = true;
      windowManager.i3.enable = true;
    };

    fonts.enableCoreFonts = true;
    fonts.extraFonts = [ pkgs.ubuntu_font_family pkgs.dejavu_fonts ];
   };
 }

