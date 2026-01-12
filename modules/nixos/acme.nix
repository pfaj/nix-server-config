{ pkgs, config, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "ajimenez4@elon.edu";

    certs."ajimenez.me" = {
      group = config.services.caddy.group;

      domain = "ajimenez.me";
      extraDomainNames = [ "*.ajimenez.com" ];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      environmentFile = "/home/monoserver/.config/env/reverseproxy.env";
    };
  };
}
