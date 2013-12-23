{ config, pkgs, ... }:

with pkgs.lib;
let
  cfg = config.services.tor.hiddenServices;
in {
  options = {
    services.tor.hiddenServices = {
      ssh.enable = mkOption {
        default = false;
        description = ''
          Enable exporting SSH as a hidden service.
          Needs services.openssh.enable.
        '';
      };
    };
  };

  config = let
      port = toString (head config.services.openssh.ports);
    in
      mkIf (cfg.ssh.enable) {
    services.tor.config = ''
      HiddenServiceDir /var/lib/tor/hidden_ssh/
      HiddenServicePort 22 127.0.0.1:${port}
    '';
  };
}
