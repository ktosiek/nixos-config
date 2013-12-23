{ config, pkgs, ... }:

with pkgs.lib;
let
  cfg = config.services.tor.hiddenServices;
  hiddenServiceOpts = { name, ... }: {
    options = {

      port = mkOption {
        example = 22;
        description = "Port on which to export the service.";
      };

      internalAddresses = mkOption {
        default = [];
        example = [ "127.0.0.1" "127.0.0.1:22" 22 ];
        description = ''
          Addresses to export. If none are given, it will use value of the port option.
          When someone connects to this service, one of those addresses will be chosen randomly.
        '';
      };

    };
  };
in {
  imports = [ <nixpkgs/nixos/modules/services/security/tor.nix> ];

  options = {
    services.tor.hiddenServices = {
      ssh = mkOption {
        default = false;
        description = ''
          Enable exporting SSH as a hidden service.
          Needs services.openssh.enable.
        '';
      };
      custom = mkOption {
        default = {};
        options = [ hiddenServiceOpts ];
        description = ''Custom published services.'';
      };
    };
  };

  config = let
    sshServices = if (!cfg.ssh) then {} else {
      ssh = { port = head config.services.openssh.ports;
              internalAddresses = []; };
    };
    hiddenServices = sshServices // cfg.custom;

  in
    mkIf (length (attrNames hiddenServices) != 0) {

    services.tor.client.enable = true;
    services.tor.config = let
      renderConfig = name: config:
        let
          addresses = if config.internalAddresses == [] then [config.port] else config.internalAddresses;
          ext_port = toString config.port;
          hiddenServicePortLines = concatStringsSep "\n"
            (map (addr: "HiddenServicePort ${ext_port} ${toString addr}") addresses);
        in ''
            HiddenServiceDir /var/lib/tor/hidden_${name}
            ${hiddenServicePortLines}
        '';
      renderedConfigs = mapAttrs renderConfig hiddenServices;
    in concatStringsSep "\n\n" (attrValues renderedConfigs);
  };
}
