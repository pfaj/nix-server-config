{ pkgs, ... }:

let
  awPort = 5600;
  awHost = "0.0.0.0";
  awDataDir = "/var/lib/activitywatch";
  awPackage = pkgs.aw-server-rust;
in
{
  users.users.activitywatch = {
    isSystemUser = true;
    group = "activitywatch";
    description = "ActivityWatch Server User";
    home = awDataDir;
    createHome = true;
  };

  users.groups.activitywatch = { };

  networking.firewall.allowedTCPPorts = [ awPort ];

  systemd.services.activitywatch-server = {
    description = "ActivityWatch Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    environment = {
      XDG_CONFIG_HOME = "${awDataDir}/.config";
      XDG_DATA_HOME = "${awDataDir}/.local/share";
      XDG_CACHE_HOME = "${awDataDir}/.cache";
    };

    serviceConfig = {
      User = "activitywatch";
      Group = "activitywatch";
      ExecStart = "${awPackage}/bin/aw-server --host ${awHost} --port ${toString awPort}";
      Restart = "always";
      RestartSec = "10s";

      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = "tmpfs";
      ReadWritePaths = [ awDataDir ];
    };
  };
}
