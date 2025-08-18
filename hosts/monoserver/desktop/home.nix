{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = with inputs.self.homeManagerModules; [
    common
    services.easy-effects
  ];

  home = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    packages = with pkgs; [
      nmap
      firefox
    ];
  };

}
