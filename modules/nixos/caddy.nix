{ ... }:
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
    # virtualHosts."office.ajimenez.me".extraConfig = ''
    #   reverse_proxy http://localhost:8080
    #
    #   tls /var/lib/acme/ajimenez.me/cert.pem /var/lib/acme/ajimenez.me/key.pem {
    #     protocols tls1.3
    #   }
    # '';
  };
}
