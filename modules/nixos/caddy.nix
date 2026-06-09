{ config, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  services.caddy = {
    enable = true;
    virtualHosts."search.ajimenez.me".extraConfig = ''
      reverse_proxy http://localhost:8888

      tls /var/lib/acme/ajimenez.me/cert.pem /var/lib/acme/ajimenez.me/key.pem {
        protocols tls1.3
      }
    '';
    virtualHosts."foto.ajimenez.me".extraConfig = ''
      reverse_proxy http://localhost:2283

      tls /var/lib/acme/ajimenez.me/cert.pem /var/lib/acme/ajimenez.me/key.pem {
        protocols tls1.3
      }
    '';
    virtualHosts."minecraft.ajimenez.me".extraConfig = ''
      reverse_proxy http://localhost:25565

      tls /var/lib/acme/ajimenez.me/cert.pem /var/lib/acme/ajimenez.me/key.pem {
        protocols tls1.3
      }
    '';

    # virtualHosts."vault.ajimenez.me".extraConfig = ''
    #   encode zstd gzip
    #
    #   # Notifications/Hub for real-time sync
    #   reverse_proxy /notifications/hub/negotiate localhost:${toString config.services.vaultwarden.config.ROCKET_PORT}
    #
    #   reverse_proxy localhost:${toString config.services.vaultwarden.config.ROCKET_PORT} {
    #       header_up X-Real-IP {remote_host}
    #   }
    # '';

    # virtualHosts."office.ajimenez.me".extraConfig = ''
    #   reverse_proxy http://localhost:8080
    #
    #   tls /var/lib/acme/ajimenez.me/cert.pem /var/lib/acme/ajimenez.me/key.pem {
    #     protocols tls1.3
    #   }
    # '';
  };
}
