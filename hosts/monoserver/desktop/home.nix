{
  inputs,
  pkgs,
  ...
}:
{
  imports = with inputs.self.homeManagerModules; [
    common
    services.easy-effects
  ];

  home = {
    packages = with pkgs; [
      nmap
      firefox
    ];
  };

}
