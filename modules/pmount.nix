{pkgs, config, ...}:

with pkgs.lib;

let
  cfg = config.security.pmount;
in

{

  ###### interface

  options = {

    security.pmount.enable = mkOption {
      type = types.bool;
      default = false;
      description =
        ''
          Whether to enable the <command>pmount</command> command, which
          allows non-root users to mount removable devices under /media.
        '';
    };

  };


  ###### implementation

  config = mkIf cfg.enable {

    security.setuidPrograms = [ "pmount" "pumount" ];

    environment.systemPackages = [ pkgs.pmount ];

  };

}
