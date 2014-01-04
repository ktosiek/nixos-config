/* XMonad with contrib and extras */

{config, pkgs, ...}:

let
  cfg = config.environment.fullXMonad;
in

with pkgs.lib;

{
  options = {
    environment.fullXMonad = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable XMonad window manager with some extras.
          '';
      };
      withKde = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable KDE too.
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      services.xserver.windowManager.xmonad.enable = true;
      services.xserver.windowManager.xmonad.enableContribAndExtras = true;
    })
    (mkIf (cfg.enable && cfg.withKde) {
      services.xserver.desktopManager.kde4.enable = true;
    })
  ];
}
