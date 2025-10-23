{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.nixpkgs) lib;
      system = "x86_64-linux";

      createSystem =
        username: hostname: configPath:
        nixosSystem {
          inherit system;
          modules = [
            configPath
            (
              { pkgs, ... }:
              {
                environment.systemPackages = with pkgs; [
                  (nixos-update {
                    configName = hostname;
                  })
                ];
              }
            )
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
          };
        };

      hostsDir = ././hosts;
      hosts =
        let
          dirs = builtins.attrNames (builtins.readDir hostsDir);
          hostSystems = builtins.map (
            userDir:
            let
              userPath = hostsDir + "/${userDir}";
              deviceDirs = builtins.attrNames (builtins.readDir userPath);
              systems = builtins.map (
                deviceDir:
                let
                  devicePath = userPath + "/${deviceDir}";
                  configPath = devicePath + "/configuration.nix";
                  hostname = "${userDir}/${deviceDir}";
                in
                {
                  "${hostname}" = createSystem userDir hostname configPath;
                }
              ) deviceDirs;
            in
            builtins.foldl' (a: b: a // b) { } systems
          ) dirs;
        in
        builtins.foldl' (a: b: a // b) { } hostSystems;
    in
    {
      nixosConfigurations = hosts;

      overlays = import ./overlays;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
    };
}
