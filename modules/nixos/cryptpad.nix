{ config, ... }:
{
  services.cryptpad = {
    enable = true;

    settings = {
      httpPort = 9000;
      httpAddress = "100.111.83.106";
      httpUnsafeOrigin = "http://100.111.83.106:${toString config.services.cryptpad.settings.httpPort}";
      httpSafeOrigin = "http://100.111.83.106:${toString config.services.cryptpad.settings.httpPort}";
      # Moved because of immich AI conflict
      websocketPort = 3004;
    };
  };

  networking.firewall.allowedTCPPorts = [ 9000 ];

  users.users.cryptpad = {
    isSystemUser = true;
    group = "cryptpad";
  };
  users.groups.cryptpad = { };
}
